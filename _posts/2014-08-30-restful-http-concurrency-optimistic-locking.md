---
layout: post
title: "RESTful HTTP: concurrency control with optimistic locking"
---

## The Problem

This is known as the **lost update problem**:

1. Agent A reads some data record (from your RESTful API in this case).
   Example: billing account of some user.
2. Agent B reads the same record.
3. Agent A modifies some fields in the record and saves the record.
   Example: $100 was added.
4. Agent B also modifies the data in some other way and saves it *without checking
   if something has changed* between the moment the record was read and the moment
   it is to be saved. Example: $1 was added.

Result: **$99 is gone** because second update overridden the first one. The first
one is lost, hence the name of the problem.

Sequence diagram: [Optimistic Offline Lock][lost-update-diag] in Martin Fowler's
[Catalog of Patterns of Enterprise Application Architecture][p-of-eaa]

[lost-update-diag]: http://www.martinfowler.com/eaaCatalog/optimisticOfflineLock.html
[p-of-eaa]: http://www.martinfowler.com/eaaCatalog/index.html

## The Solution

There are several ways to prevent this, and *optimistic locking* is the one that
best fits the case of RESTful APIs:

1. Agent A reads some data record, API returns a *version* of this record
   together with data itself. In HTTP, this is done via 
   [`ETag` header](http://en.wikipedia.org/wiki/HTTP_ETag)
   Example: the version is `ETag: W/"1"`. It can be any string, usually 
   an ordinal number or a checksum of data. `W/` means "weak" validation, 
   which is semantic equivalence instead of byte-to-byte equality.
2. Agent B reads the same records with the same version.
3. Agent A modifies some fields in the record and saves the record, 
   passing `If-Match: W/"1"`. Server accepts changes and increments the version.
4. Agent B also modifies the data and also tries to save it with `If-Match: W/"1"` 
   being passed. Server *rejects* those changes because the version has changed. 
   This must be done by sending a response with `412 Precondition Failed` status.
   If no `If-Match` header is provided by a client, server must respond with
   `428 Precondition Required` status.
   
### Advantages

- **No read locking**. It's *optimistic* because it assumes that most of the time
  it's fine to allow reading the data being edited at the moment. Reading doesn't
  imply that update will follow next.
- No session is required to keep track of locking. The lack of session is required
  in order to comply REST principles: it must be *stateless* to be RESTful.
- Simple to implement on top of HTTP. In fact, you just need to read 
  [RFC 7232](http://tools.ietf.org/html/rfc7232).

### Disadvantages

- No guarantee you will be able to save a record once you've read it. Imagine
  client A updates user account so that user name "John Doe" becomes "John Smith"
  and client B changes it to "Jack Doe": which is the correct way to merge those
  changes? Maybe it is "Jack Smith", but this would require a human to decide.
  There are, of course, much more complex cases.

And that's the only one real disadvantage I'm aware of.

## Support by frameworks

If your framework (I mean ORM or other database frameworks) doesn't support
optimistic locking, I'd suggest you choose a different one if you're going to
implement RESTful API.

This is how it's done in some Java frameworks:

- In [Hibernate ORM][hibernate-orm] (in fact, in 
  <acronym title="Java Persistence API">JPA</acronym> standard): 
  just use `@Version` annotation on bean properties.
- In [jOOQ][jooq], as of version 3.4: read [Optimistic locking][jooq-opt-lock]
  section and [Advanced code generation][jooq-adv-codegen], namely about 
  `recordVersionFields` and `recordTimestampFields` properties.

[hibernate-orm]: http://hibernate.org/orm/
[jooq]: http://www.jooq.org/
[jooq-opt-lock]: http://www.jooq.org/doc/3.4/manual/sql-execution/crud-with-updatablerecords/optimistic-locking/
[jooq-adv-codegen]: http://www.jooq.org/doc/3.4/manual/code-generation/codegen-advanced/

Other frameworks with *explicit* support I know:

- PHP: [Doctrine ORM](http://www.doctrine-project.org/projects/orm.html)
- Ruby: [Ruby on Rails](http://rubyonrails.org/)
- C#: [Entity Framework](http://msdn.microsoft.com/en-us/data/ef.aspx)

By *explicit* support of optimistic locking I mean that there is a special 
function/annotation/property just for that. If there isn't, you still can
do this manually by checking version in your code or adding something like
`WHERE VERSION = :version` to your SQL.

You can do concurrency control even with no framework at all, so don't be upset
if your favorite ORM lacks explicit support.

## Further reading

- [Concurrency control](http://en.wikipedia.org/wiki/Concurrency_control)
- [Optimistic concurrency control](http://en.wikipedia.org/wiki/Optimistic_concurrency_control)
- [RFC 7232](http://tools.ietf.org/html/rfc7232): HTTP/1.1: Conditional Requests
