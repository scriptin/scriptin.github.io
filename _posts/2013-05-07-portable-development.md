---
layout: post
title: Portable development
---

**Post summary**: Portable development is a software development practice in which initial setup of development environment (editor/IDE and virtual machine running the application under develoment) is done by just cloning repositories with code and configuration and running a few commands in a terminal. This is achived by using [Vagrant][vagrant] for virtual machine management and editors/IDEs which use configuration in textual formats, like Vim or Emacs.

----

Imagine the situation when a new developer (let's call him Jimmy) comes to a consolidated team working on a long-term project for several months. First thing Jimmy needs to do is to set up his development environment and get the application running. You probably can imagine how bad can it be.

Let's consider few imaginary cases of how could Jimmy setup his environment.

### Worst case scenario: manual setup

The team Jimmy came into working on legacy PHP application. The company guys work for forces them to use Windows on their workstations. In order to develop PHP on Windows, Jimmy uses something like XAMPP/WAMP/EasyPHP, which itself can lead to a problem, because production server runs Linux, and it is easy to screw things up - for example, if you use `/` instead of `DIRECTORY_SEPARATOR` in some functions. Even if Jimmy is aware of all such cases, there will be situations when his development environment is different from production server in a way that leads to disaster.

After installing XAMPP, Jimmy installs Eclipse, trying to remember where to set this goddamn default EOL characters and ton of other stuff. This is another place to mess up, because Jimmy can, for example, accidentaly convert encoding on all files he will work with, or break team coding style in other way, if he's lucky enough to have a team wich uses any coding style.

Next Jimmy gets a copy of project's repository and fails horribly trying to run the application:

- Repository has outdated dump of database.
- Some configuration files are supposed to be edited manually before the thing can run.
- Application requires some PEAR/PECL modules. PEAR on Windows is a pain in the ass, I tell you.
- In order to test some parts of code you have to add some data manually through phpMyAdmin.
- The only guy who knows how to do all the things above is in a hospital bacause he was hit by a truck.

Jimmy is now into a situation where his boss expects him to start fixing some 2 years old bug which noone wants to take on, but the first time when Jimmy can actually see the applecation working on his computer is at least a week away. So Jimmy starts hacking the code directly on production server, yay! Just kidding... Or not.

### Improvement #1: using editor/IDE with portable confuguration

The thing I personally don't like about Eclipse and similar IDEs, is it's unportable (or hardly portable) configuration. Better alternative would be having IDE's configuration files stored in repository, and that is possible for Vim and Emacs.

For example, here is my Emacs congiguration: [github.com/scriptin/.emacs.d](https://github.com/scriptin/.emacs.d) (at the moment of writing this post, it cannot be used as an IDE, but I've just started working with Emacs and constantly improving it). If I was in Jimmy's shoes, I'd just clone my congiguration to my new workstation and ended up with setting I'm already used to have. I'm not trying to say that Emacs/Vim are superior to Eclipse (or vice versa), but with portable configuration you can:

- setup your editor/IDE in a few minutes after installation.
- update your configuration from anywhere and have these changes available everywhere.
- share your configuration with others and others can do same.
- use your configuration as an example to teach other people and learn from them in a same way.

### Improvement #2(a): using virtual machine for development

Jimmy's team can build a <acronym title="Virtual Machine">VM</acronym> specifically to run their application. They could build it to mimic porduction environment as closely as possible, so a bunch of initial setup frustration would be gone.

Additionaly, if thier project runs on multiple servers (i.e. has a load balancer, application and data servers, etc.), using VMs is the only way to make it runnable.

However, building a VM (or multiple VMs) and sharing it as an image file has following disadvantages:

- You have to syncronize the state of each copy of VM with production environment manually either by each team meber individually or by a single person who's responsible for this. In former case VMs of eac person on the team would get desynced very fast. In latter case each time a change is done each person would have to tear his/her VM down and get a new copy.
- Sharing VM image file is inefficient bacause of it's size.
- It's no clear how exactly environment is set up: which packages, modules, extentions are used, what settings HTTP-server use, etc.
- VM is detached from the code it is supposed to be running.

### Improvement #2(b): using Vagrant

[Vagrant][vagrant] is a much better alternative for managing virtual development environments. With Vagrant Jimmy would have to write a special `Vagrantfile` (Vagrant's equivalent of `Makefile` and similar), which contains instructions of how to setup a VM. He would be able to use [provisioning](http://docs.vagrantup.com/v2/provisioning/index.html) scripts written in bash, Ruby or other formats, depending on chosen provisioning tool (I personnaly prefer [Chef solo](http://docs.vagrantup.com/v2/provisioning/chef_solo.html)).

Vagrant configuration is:

- **Compact**: it is just a set of text files, so it can (and should) be a part of project code.
- **Editable**: it is a code, so it can (and should) be source controlled and edited but whole team.
- **Visible**: you can see what exactly included in configuration.
- **Reproduceable**: you can tear down and rebuild your copy of VM with just one command whenever you want.
- **Idempotent** (this actually depends on provisioner and some other things): provisioner keeps track of VM state, preventing of running same steps more than once.

[vagrant]: http://vagrantup.com
