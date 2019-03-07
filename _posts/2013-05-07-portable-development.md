---
layout: post
title: Portable development
---

**Post summary**: Portable development is a software development practice in which initial setup of development environment (editor/IDE and virtual machine running the application under develoment) is done by just cloning repositories with code and configuration and running a few commands in a terminal (or pressing a few buttons). This can be achieved by using [Vagrant][vagrant] for virtual machine management and editors/IDEs which use configuration in textual formats, like Vim or Emacs.

*Note*: As far as I know, the term "portable development" is not official or even commonly used. I use it here as an umbrella term for several practices, technologies, and tools.

----

Imagine the situation when a new developer (let's call him Jimmy) comes to a consolidated team working on a long-term project for several months. First thing Jimmy needs to do is to set up his development environment and get the application running. You probably can imagine how bad can it be.

Let's look at the few imaginary cases of how could Jimmy setup his environment.

## Worst case scenario: manual setup

The team Jimmy came into working on legacy PHP application. The company guys work for forces them to use Windows on their workstations. In order to develop PHP on Windows, Jimmy uses something like XAMPP/WAMP/EasyPHP, which itself can lead to a problem, because production server runs Linux, and it is easy to screw things up - for example, if you use `"/"` or `"\"` instead of `DIRECTORY_SEPARATOR` in some functions. Even if Jimmy is aware of all such cases, there will be situations when his development environment is different from production server in a way that leads to a disaster.

After installing XAMPP, Jimmy installs Eclipse, trying to remember where to set this damn default EOL character and a ton of other stuff. This is another place to mess up, because Jimmy can, for example, accidentally convert encoding on all files he will work with, or break team coding style in other way, if his team has it.

Next Jimmy gets a copy of project's repository (it should be simple) and then fails horribly trying to run the application:

- Repository has outdated dump of database for development and no one has the full version.
- Some configuration files are supposed to be edited manually to make it work.
- Application requires some PEAR/PECL modules. PEAR on Windows is a pain in the ass, I tell you.
- In order to test some parts of code you have to add some data manually through phpMyAdmin or by creating and editing some files.
- The only guy who knows how to do all the things above is in a hospital because he was hit by a truck.

Jimmy finds himself in a situation where his boss expects him to start fixing some 2 yeaars old bug which no one wants to take on, but the first time when Jimmy can actually see the application working on his computer is at least a week away. So Jimmy starts hacking the code directly on production server, yay! Just kidding... Or not.

## Improvement 1: using editor/IDE with portable configuration

The thing I personally don't like about Eclipse and similar IDEs is it's unportable (or hardly portable) configuration. Better alternative would be having IDE's configuration files stored in repository, and that is possible for Vim and Emacs. For example, here is my Emacs configuration: [github.com/scriptin/.emacs.d](https://github.com/scriptin/.emacs.d) (at the moment of writing this post it cannot be used as an IDE, but I work on it).

If I were in Jimmy's shoes, I'd just clone my configuration to my new workstation and ended up with settings I'm already used to have. I'm not trying to say that Emacs/Vim are superior to Eclipse (or vice versa), but with portable configuration you can:

- setup your editor/IDE in a few minutes after installation.
- update your configuration from anywhere and have these changes available everywhere.
- share your configuration with other people.
- use your configuration as an example to teach other people and learn from them in a same way.

## Improvement 2: using virtual machine for development

Jimmy's team can build a <acronym title="Virtual Machine">VM</acronym> which mimics production environment as closely as possible to run their application. If their project runs on multiple servers (i.e. has a load balancer, application and data servers, etc.), using VMs is the only way to make it runnable on a single computer.

However, building a VM (or multiple VMs) and sharing it as an image file has following disadvantages:

- You have to synchronize the state of each copy of VM with production environment manually either by each team member individually or by a single person who's responsible for this. In former case VMs of each team member would get desynched very fast. Latter case is better, but still each time a change is done each person would have to get a new copy of VM.
- Sharing VM image file is inefficient because of it's size.
- It's not clear how exactly environment is set up: which packages, modules, extensions are used, what settings HTTP server use, etc.
- VM is detached from the code it is supposed to run.

## Improvement 3: using Vagrant

[Vagrant][vagrant] is a much better alternative for managing virtual development environments. With Vagrant Jimmy would have to write a special `Vagrantfile` (Vagrant's equivalent of `Makefile` and similar), which contains instructions of how to setup a VM. He would be able to use [provisioning](http://docs.vagrantup.com/v2/provisioning/index.html) scripts/configurations written in bash, Ruby or other formats, depending on chosen provisioning tool (I personally prefer [Chef solo](http://docs.vagrantup.com/v2/provisioning/chef_solo.html)).

Vagrant configuration is:

- **Compact**: it is just a set of text files, so it can (and should) be a part of project code.
- **Editable**: it is a code, so it can (and should) be source controlled and edited buy the whole team, just like the code itself.
- **Visible**: you can see what exactly is included in it.
- **Reproducible**: you can tear down and rebuild your copy of VM with just one command whenever you need.
- **Idempotent** (this actually depends on provisioner and some other things): provisioner keeps track of VM state, preventing of running same steps more than once.

If you don't use Vagrant now, at least read the [documentation][vagrant_docs] to get an idea of how it can be beneficial to you. I use Vagrant for this blog (see [repository](https://github.com/scriptin/scriptin.github.io)) and other projects.

**Related post**: [Minimal practical introduction to Vagrant and Chef solo]({% post_url 2013-05-09-vagrant-chef-intro %})

[vagrant]: http://vagrantup.com
[vagrant_docs]: http://docs.vagrantup.com/v2/

## Alternative 1: using online IDEs

You've probably heard about [Cloud9][] or similar web-based IDEs. Personally I've never used anything more than [JSFiddle][], [SQLFiddle][], and [CodeMirror][], so I can't judge how good or bad it can be, but I can guess it is a tradeoff between simplicity of collaboration (which seems to be very simple), performance (complex IDE in a browser can be slow just because of network latency), customization (I don't believe you can build Emacs in a browser), and a bunch of other factors.

[Cloud9]: https://c9.io/
[JSFiddle]: http://jsfiddle.net/
[SQLFiddle]: http://sqlfiddle.com/
[CodeMirror]: http://codemirror.net/

## Alternative 2: Desktop virtualization

[Desktop virtualization](http://en.wikipedia.org/wiki/Desktop_virtualization) is a way to get rid of development environment setup process by building a ready to use desktop environments in a cloud and then giving the developers remote access to the copies of those virtualized desktops.

This can be a good solution for companies which outsource part of their development, because you can minimize developer's access to sensitive data and other resources while still being able to provide each developer with everything what's required to work on a project. However, this approach forces a developer to use whatever tools a company have chosen.
