---
title: Minimal practical introduction to Vagrant and Chef solo
layout: post
---
First time I tried to use [Vagrant][] with [Chef][] solo as a [provisioner](http://docs.vagrantup.com/v2/provisioning/index.html) I got stuck with too much irrelevant information on the topic. So here is the short introduction to get you started.

Before reading this post:

- Make sure you know why to use [Vagrant][]. My post about [portable development]({% post_url 2013-05-07-portable-development %}) explains this.
- Read some [Vagrant documentation][] - it's simple enough, so I decided not include it here. Feel free to skip sections about provisioners other than Chef solo and other stuff you think you will not need.
- Make sure you know why to use [Chef][] (in short: it's better than tons of bash scripts) and what is [Chef solo][] (in short: it is a standalone open source version of Chef).
- If you don't know [Ruby][] at all, read [Just Enough Ruby for Chef](http://docs.opscode.com/just_enough_ruby_for_chef.html) from [Chef documentation][].

[Vagrant]: http://vagrantup.com
[Vagrant documentation]: http://docs.vagrantup.com/v2/
[Chef]: http://www.opscode.com/chef/
[Chef documentation]: http://docs.opscode.com/
[Chef solo]: http://docs.opscode.com/chef_solo.html
[Ruby]: http://www.ruby-lang.org/
