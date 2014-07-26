---
layout: post
title: "RESTful HTTP: organizing URLs"
---

For the last few week I've been working a lot on designing/implementing some web services, moslty [REST][]ful, so I decided to write down the most important things I've learned so far. This post is about oraganizing URLs of resources in a web service in a smart way.

Few basic things before I start:

- [REST][] is neither a technology, nor a standart. It is a set of architectural principles
- REST can be used over various protocols, but I'm going to talk only about HTTP. If you're not familiar with specification of this protocol, you might want to read [RFC 2616][]
- REST can use various data formats (XML, CSV, binary, etc.), I'll stick with [JSON][]

[REST]: https://en.wikipedia.org/wiki/Representational_state_transfer
[RFC 2616]: http://tools.ietf.org/html/rfc2616
[JSON]: http://json.org/

----

In REST terms, the state (data) provided and managed by a web service is organized into resources (units of state). For example, URL `http://example.com/products/` may be a resource which is a list of products, while `http://example.com/products/123` is a resource representing a single product.

Each resource has an URL (URI actually, but since I talk about HTTP, those two are interchangeable), and those URLs usually form a logical hierarchy.

There are two common types of resources: collections (lists or sets of data) and single items (usually inside a collection).

## Organizing collections

> Rule 1: URLs of collection resources should end with slash (`/`),
> URLs of single items should not

It will prevent clients of web service from messing up relative paths - see "[Why trailing slashes on URIs are important](http://cdivilly.wordpress.com/2014/03/11/why-trailing-slashes-on-uris-are-important/)" for in-depth explanation.

> Rule 2: each resource should be accessible via only one URL

Consider you have web service with two types of entities: "user" and "group". Each user can belong to one or more groups. Since logically users are "nested" in groups (groups contain users), you may want to organize your URLs like `/groups/123/users/456` - which is user with ID=456 inside a group with ID=123. But the exact same user may be in a different group - `/groups/789/user/456`.

Bad things may happen when the same resource can be changed or deleted using different URLs. Quick example: how would you know if `DELETE /groups/123/users/456` deleted user resource entirely or just excluded it from a group?

To prevent such things, you should leave only one way of accessing each resource - `/users/456` in this case. To get a list of users in a specific group, consider two options:

1. Creating a resource like `/groups/123/user-ids/` which provides read-only access to a list of users' IDs: `[123, 42, 12]`
2. Provide a list of links to users in a group resource

I recommend the latter approach, which can be done in two ways:

{% highlight json %}
{
    "id": 123,
    "name": "Group 1",
    "users": [456, 42]
}
{% endhighlight %}

where `"users"` is a list of IDs of users.

{% highlight json %}
{
    "id": 123,
    "name": "Group 1",
    "users": ["/users/456", "/users/42"]
}
{% endhighlight %}

where `"users"` is a list of absolute URLs to resources, but they can also be relative:

{% highlight json %}
{
    "id": 123,
    "name": "Group 1",
    "users": ["../users/456", "../users/42"]
}
{% endhighlight %}

This is where **Rule 1** shines. You can take those URLs and append them to current URL to get absolute URLs of users in a group:

1. `http://example.com/groups/123` + `../users/456` =>
2. `http://example.com/groups/../users/456` =>
3. `http://example.com/users/456`

Note how `123` part gets omitted - this is how relative URLs actually work. Just imagine if `123` was a file and `groups` was a current working directory: then `cat ../users/456` would print the contents of file `456` in a `users` directory which is right next to `groups`. 

You can also refer to groups from user resource:

{% highlight json %}
{
    "id": 456,
    "name": "John Doe",
    "groups": ["../groups/123", "../groups/789"]
}
{% endhighlight %}

Now to add/remove user to/from a group, you can update either `"users"` list in a `/group/XXX` resource or `"groups"` list in `/users/YYY` resource - whatever fits best.

This brings us to the next rule:

> Rule 3: if two resource types have many-to-many relation, don't nest them.
> Make two separate resources on the same level of hierarchy

This will help you follow **Rule 2**.

Example with groups and users above demonstrate many-to-many relation, so it's better to make `/users/` and `/groups/` separate instead of putting users inside groups or other way around.

This rule is not applicable to situations when resources form a proper tree (because in that case there is no many-to-many relation), so be careful. For example, if each user could be in only one and exactly one group, it would be perfectly fine to nest users resource path inside the groups resource path.

## Moving item from one collection to another

RESTful service should use proper HTTP methods: `GET` to read, `POST` to create, `PUT` to update, and `DELETE` to remove resources. Consider the case when user can be in only one group - what HTTP request would move the user to another group?

Example: there is a user `/groups/123/users/456` and you want to move it to `/groups/789`, so it becomes `/groups/789/users/456` or, if preserving user ID is not important, `/groups/789/users/X`, where X is auto-generated ID.

> Option 1: GET-DELETE-POST - **not recommended**

This is very simple, but requires 3 requests. Also it does not preserve the ID of user being moved.

    GET /groups/123/users/456    - get the data
    DELETE /groups/123/users/456 - delete old resource
    POST /groups/789/users/      - create new resource with new ID

I do not recommend this approach bacause it is not atomic. If something goes wrong after `DELETE` request, the data can be *lost forever*.

> Option 2: GET-DELETE-PUT - **not recommended**

Almost the same as previous, except it preserves the ID.

    GET /groups/123/users/456    - get the data
    DELETE /groups/123/users/456 - delete old resource
    PUT /groups/789/users/456    - create new resource with same ID

I would not recommend this approach because it can cause collisions - situations when you overwrite resource with last `PUT` request. Also it is also not atomic.

> Option 3: WebDAV MOVE method

`MOVE` method of [WebDAV][] is nice bacause it uses only 1 request, so it's atomic if server performs this action atomically. Disadvantage is that not all client software support this. Read this about the support in major browsers: [Are the PUT, DELETE, HEAD, etc methods available in most web browsers?](http://stackoverflow.com/q/165779/484666)

Request:

    MOVE /groups/123/users/456 HTTP/1.1
    Host: www.example.com
    Destination: http://www.example.com/groups/789/users/456

Response:

    HTTP/1.1 201 Created
    Location: http://www.example.com/groups/789/users/456

I will not discuss WebDAV approach in detail, this is just information to start with. Read the [RFC 4918][WebDAV] if client support issues are not relevant to your case.

[WebDAV]: http://tools.ietf.org/html/rfc4918

> Option 4: POST/PUT with empty body

Remember: `/groups/789/users/456` doesn't exist yet, we want it to be the new location of `/groups/123/users/456`

Request:

    POST /groups/789/users/456 HTTP/1.1
    - or -
    PUT /groups/789/users/456 HTTP/1.1

Response:

    HTTP/1.1 204 No Content

This might seem strange (creating or updating resource with no body), but it works: server should get the user data by provided ID=456 and move the user to a group with ID=789. If there is no user or no group with such IDs, request should fail with `404 Not Found`.

Also you can support both this approach and WebDAV `MOVE` method from **Option 3**, giving capable clients more semantic way of moving the resource.
