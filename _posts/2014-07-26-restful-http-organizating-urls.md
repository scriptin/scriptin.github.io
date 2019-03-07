---
layout: post
title: "RESTful HTTP: organizing URLs"
---

For the last few week I've been working a lot on designing/implementing some web services, mostly [REST][]ful, so I decided to write down the most important things I've learned so far. This post is about organizing URLs of resources in a web service in a smart way.

Few basic things before I start:

- [REST][] is neither a technology, nor a standard. It is a set of architectural principles
- REST can be used over various protocols, but I'm going to talk only about HTTP. If you're not familiar with specification of this protocol, you might want to read <del>[RFC 2616][]</del> ([obsolete since June 2014][rfc-2616-obsolete]), [RFC 7230][], [RFC 7231][], [RFC 7232][], [RFC 7233][], [RFC 7234][], [RFC 7235][]
- REST can use various data formats (XML, CSV, binary, etc.), I'll stick with [JSON][]

[REST]: https://en.wikipedia.org/wiki/Representational_state_transfer
[JSON]: http://json.org/
[RFC 2616]: http://tools.ietf.org/html/rfc2616
[rfc-2616-obsolete]: https://www.mnot.net/blog/2014/06/07/rfc2616_is_dead
[RFC 7230]: http://tools.ietf.org/html/rfc7230
[RFC 7231]: http://tools.ietf.org/html/rfc7231
[RFC 7232]: http://tools.ietf.org/html/rfc7232
[RFC 7233]: http://tools.ietf.org/html/rfc7233
[RFC 7234]: http://tools.ietf.org/html/rfc7234
[RFC 7235]: http://tools.ietf.org/html/rfc7235

----

In REST terms, the state (data) provided and managed by a web service is organized into resources (units of state). For example, URL `http://example.com/products` may be a resource which is a list of products, while `http://example.com/products/123` is a resource representing a single product.

Each resource has an URL (URI actually, but since I talk about HTTP, those two are interchangeable), and those URLs usually form a logical hierarchy.

There are two common types of resources: collections (lists or sets of data) and single items (usually inside a collection).

## Organizing collections

> Rule 1: each resource should be accessible via only one URL

Consider you have web service with two types of entities: "user" and "group". Each user can belong to one or more groups. Since logically users are "nested" in groups (groups contain users), you may want to organize your URLs like `/groups/123/users/456` - which is user with ID=456 inside a group with ID=123. But the exact same user may be in a different group - `/groups/789/user/456`.

Bad things may happen when the same resource can be changed or deleted using different URLs. Quick example: how would you know if `DELETE /groups/123/users/456` deleted user resource entirely or just excluded it from a group?

To prevent such things, you should leave only one way of accessing each resource - `/users/456` in this case. To express the relation between two types of resources, you should use special fields:

```json
{
    "id": 123,
    "name": "Group 1",
    "users": [456, 42]
}
```

```json
{
    "id": 456,
    "name": "John Doe",
    "groups": [123, 789]
}
```

Now to add/remove user to/from a group, you can update (using PUT request) either `"users"` list in a `/group/XXX` resource or `"groups"` list in `/users/YYY` resource - whatever works better.

This brings us to the next rule:

> Rule 2: if two resource types have many-to-many relation, don't nest them.
> Make two separate resources on the same level of hierarchy

This will help you follow **Rule 1**.

Example with groups and users above demonstrate many-to-many relation, so it's better to make users and groups separate instead of putting users inside groups or other way around.

This rule is not applicable to situations when resources form a proper tree (because in that case there is no many-to-many relation), so be careful. For example, if each user could be in only one and exactly one group, it would be perfectly fine to nest users resource path inside the groups resource path.

## Moving item from one collection to another

RESTful service should use proper HTTP methods: `GET` to read, `POST` to create, `PUT` to update, and `DELETE` to remove resources. Consider the case when user can be in only one group - what HTTP request would move the user to another group?

Example: there is a user `/groups/123/users/456` and you want to move it to `/groups/789`, so it becomes `/groups/789/users/456` or, if preserving user ID is not important, `/groups/789/users/X`, where X is auto-generated ID.

> Option 1: GET-DELETE-POST - **not recommended**

This is very simple because no additional methods need to be supported.

    GET /groups/123/users/456    - get the data
    DELETE /groups/123/users/456 - delete old resource
    POST /groups/789/users/      - create new resource with new ID

I do not recommend this approach because it is not atomic. If something goes wrong after `DELETE` request, the data can be *lost forever*.

> Option 2: WebDAV MOVE method

`MOVE` method of [WebDAV][] is nice because it uses only 1 request, so it's atomic if server performs this action atomically.

Request:

    MOVE /groups/123/users/456 HTTP/1.1
    Host: www.example.com
    Destination: http://www.example.com/groups/789/users/456

Response:

    HTTP/1.1 201 Created
    Location: http://www.example.com/groups/789/users/456

I will not discuss WebDAV approach in detail, this is just information to start with. Read the [RFC 4918][WebDAV] if client support issues are not relevant to your case.

[WebDAV]: http://tools.ietf.org/html/rfc4918

## Further reading

- [The RESTful CookBook](http://restcookbook.com/) - online book about REST, both basic and advanced topics
- [Why trailing slashes on URIs are important](http://cdivilly.wordpress.com/2014/03/11/why-trailing-slashes-on-uris-are-important/) - kinda controversial article about trailing slashes on collections. I do not recommend to follow this rule since it's not obvious unless you've read this article. Initially I included this as a rule but after some snooping around popular REST APIs changed my mind. Note how URL of this article ends with slash when it shouldn't =)