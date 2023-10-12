---
layout: post
title: "RESTful HTTP: error handling"
---

Error handling in web services (REST, JSON-RPC, etc.) is a process of catching exceptions, logging them properly, and translating them into HTTP-compliant responses with human-readable error messages:

- **HTTP-compliant**: responding with proper statuses, proper headers for that statuses, and so on.
- **Logging properly**: configuring logging system so logs can be efficiently used to find, analyze, and fix bugs.
- **Human-readable error messages**: for example, saying *"You can't delete X because it is used in Y"* and not *"org.hibernate.exception.ConstraintViolationException: Could not execute JDBC batch update"*. Of course, responses should also be machine-readable (JSON/XML).

I use Java in my examples, but this should be similar for any decent OOP language.

## Naive error handling and common mistakes

- No error handling.
- "Swallowing" exceptions in empty `catch` blocks.
- "Overriding" exceptions thrown inside `try` blocks by [exceptions thrown inside `catch` or `finally` blocks][fail-safe-handling].
- Breaking stack trace by catching an exception and throwing another without setting the previous one as the cause.
- Exposing the "guts" to a client: full stack trace, environment variables' values, etc.
- Too implementation-specific or "low-level" error messages, e.g. *"com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (\`foo\`.\`bar\`, CONSTRAINT \`baz_ibfk_1\` FOREIGN KEY (\`id\`) REFERENCES \`qux\` (\`id\`))"*.
- Too generic error messages. Like "failed to delete X" (why?), "request processing error" (what happened?), etc.
- Guessing the cause of an error by parsing exception message. You'd need a strong AI for that, yet you use good ol' regular expressions.
- Throwing and catching general-purpose exceptions to convey business-specific information. Like throwing `NullPointerException` to say "there's no record with given ID in database", and then assuming all NPEs you catch mean exactly that.
- Not logging errors.
- Too much logging, logging irrelevant things or just gibberish.
- Logging same things more than once.
- Logging with improper severity levels, etc.

[fail-safe-handling]: http://tutorials.jenkov.com/java-exception-handling/fail-safe-exception-handling.html

Now, onto fixing that.

## Logging

My favourite logging framework in Java is [Logback](http://logback.qos.ch/), so I will use severity levels it uses: TRACE, DEBUG, INFO, WARN, ERROR. If you don't understand what are those and why they exist, please read [the docs][logback-levels] before you continue.

You should always log stack traces for exceptions which you code does not know how to handle. It is typical that you also respond with `500 Internal Server Error` in such cases, because this should be considered like something truly unexpected. For those exceptions you handle, you can just log error message, and provide stack trace as a debugging information.

ERROR, WARN, and INFO must be logged into your primary log. As for DEBUG and TRACE messages, don't put them there to prevent disk consumption issues. Use [syslog][] or similar mechanisms instead, or at least separate properly [rotated][log-rotation] log. You should be able to turn off debugging log without restarting your application.

[logback-levels]: http://logback.qos.ch/manual/architecture.html#effectiveLevel
[syslog]: http://en.wikipedia.org/wiki/Syslog
[log-rotation]: http://en.wikipedia.org/wiki/Log_rotation

## Exception handling layers

Read this article first: [Logging Exceptions: Where to Log Exceptions?][log-layers]

I know you've skipped it, so here's a summary: there are different layers in your code on which you can potentially log exceptions. Mr. Jenkov uses 3, but I'll split the "top" one since this article is specifically about web services:

- Bottom layer: places where exceptions are thrown or first encountered.
- Middle layer: this may be your Services, Repositories, etc.
- Top layer A: API implementation.
- Top layer B: error interceptor/wrapper/handler - many REST frameworks provide a way to stick one.

[log-layers]: http://tutorials.jenkov.com/java-exception-handling/logging-where-to-log-exceptions.html

### Bottom and middle layer

- Do NOT log errors here!
- If error occurred outside of your code (in some library or framework you're using):
    - handle it, if possible,
    - if not, enrich it by wrapping into *domain-specific* exception classes and rethrow,
    - use [exception handling templates][handling-templates].
- If you're about to throw an exception, use *domain-specific* exception classes, providing enough information to explain what happened.
- Avoid using general-purpose exceptions in cases where you can be more specific, since you won't be able to tell apart those thrown from your code from those thrown elsewhere, thus you won't be able to handle them properly later.

By saying "domain-specific" I mean related to business domain (area of knowledge), not like in "domain name of a web site".

[handling-templates]: http://tutorials.jenkov.com/java-exception-handling/exception-handling-templates.html

### API implementation layer

- Do NOT log errors here! You may log WARN/INFO messages here in case when something potentially dangerous happens, but not an actual error.
- Handle domain-specific exceptions, if possible.
- If not, enrich by wrapping into *API-specific* exception classes and throw further.

API-specific exceptions are different from domain-specific exceptions because the latter can be used elsewhere. Also API-specific exceptions should help you determining which response status and message should be presented to a client. Typically you just display error messages from those exceptions to a client, so they should be clear. For example:

```java
// Assume that all those exception classes
// extend some base class `ApiException`

throw new ApiNotFoundException(
    404,
    "Entity with id=" + id + " not found."
);

throw new ApiDatabaseUnavailableException(
    502,
    "Database server is unavailable. Retry later."
);

throw new ApiConstraintViolationException(
    422, // WebDAV, Unprocessable Entity
    "Entity with id=" + id + " cannot be deleted " +
    "because it is a parent of entity with id=" + childId + ". " +
    "Delete all children first."
);
```

### Error interceptor/wrapper/handler layer

- Log errors here, finally!
- Translate all known domain-specific and API-specific exceptions (and maybe other kinds, but only if you don't have to parse message) into HTTP equivalents with human-readable messages.
- For general-purpose exceptions like `NullPointerException`, `IllegalStateException` and such, return `500 Internal Server Error`, without providing any security-sensitive information. Those exceptions should be dealt with (handled or wrapped) at lower layers.

Code might look like this:

```java
    // ...
} catch (ApiException e) {
    // Caught ApiException or one of its subclasses
    // Can safely use its error message and status
    response.setStatus(((ApiException) e).getStatus());
    response.setMessage(e.getMessage());
} catch (DomainMailServerUnavailableException e) {
    // Caught a domain-specific exception
    // which says that mail server is down
    response.setStatus(502);
    response.setMessage("Mail server is unavailable. Retry later.");
} catch (DomainAccessDeniedException e) {
    // Caught another domain-specific exception
    response.setStatus(503);
    response.setMessage(
        "You have insufficient privileges to perform this action."
    );
} catch (Exception unhandledException) {
    // Catch-all case:
    // 1. Log the exception
    logger.error(
        "Unhandled exception!",
        unhandledException
    );
    // 2. Notify devs/admins
    systemAlarm.unhandledException(unhandledException.getMessage());
    // 3. Show a generic error to users
    response.setStatus(500);
    response.setMessage(
        "Sorry, something is broken. We're looking into that."
    );
}
```

## Error handling flow

The flow of exception handling should generally look like this:

1. Throwing/encountering general-purpose exceptions.
2. Wrapping them into domain-specific exceptions. Or handling, if possible.
3. Wrapping those into API-specific exceptions if necessary. Or handling, if possible.
4. Building API responses with human-readable error messages you get from domain and API layer exceptions.

There are rare cases where wrapping in steps 2 and/or 3 can be skipped. Think carefully.

## Custom error codes

Sometimes HTTP statuses are just not enough to explain the meaning of all possible errors, that's why we also provide messages. However, clients may need to localize those messages or take some other actions depending on what's happened, and keeping a list of all possible error messages on a client is not a right thing to do.

Many APIs provide their custom error codes *in addition* to HTTP statuses:

- [Twitter API error codes](https://dev.twitter.com/overview/api/response-codes)
- [Facebook Graph API error codes](https://developers.facebook.com/docs/graph-api/using-graph-api/v2.2#errors)

As you can see, those codes provide the same information as messages do, but are more convenient to handle when you need to take actions or display custom text.

## Summary

**DO**:

- Use domain/API-specific exceptions with direct, precise, implementation-agnostic error messages written in plain language.
- Log errors only once, at the top layer of your code.
- Log debugging information separately.
- Handle exceptions which you can handle right away.
- Enrich exceptions you can't handle on a current layer by wrapping them into domain-specific exceptions, providing additional information.
- Comply HTTP protocol.

**DO NOT**:

- "Swallow" exceptions completely or break stack trace chain.
- Use general-purpose exception classes to convey domain-specific meaning.
- Parse message text to figure out what caused an error.
- Show "raw" error messages to a client, revealing implementation details.
- Log everything multiple times, putting too much irrelevant, duplicate or excess messages into logs.
