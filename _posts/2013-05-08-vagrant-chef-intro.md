---
title: Minimal practical introduction to Vagrant and Chef solo
layout: post
---
First time I tried to use [Vagrant][] with [Chef][] solo as a [provisioner](http://docs.vagrantup.com/v2/provisioning/index.html) I got stuck with too much irrelevant information on the topic. So here is the short introduction to get you started.

Before reading this post:

- Make sure you know why to use Vagrant. My post about [portable development]({% post_url 2013-05-07-portable-development %}) explains this.
- Read some [Vagrant documentation][] - it's simple enough, so I decided not include it here. Feel free to skip sections about provisioners other than Chef solo and other stuff you think you will not need.
- Make sure you know why to use Chef (in short: it's better than tons of bash scripts) and what is [Chef solo][] (in short: it is a standalone open source version of Chef).
- If you don't know [Ruby][] at all, read [Just Enough Ruby for Chef][] from [Chef documentation][].

[Vagrant]: http://www.vagrantup.com/
[Vagrant documentation]: http://docs.vagrantup.com/v2/
[Chef]: http://www.opscode.com/chef/
[Chef documentation]: http://docs.opscode.com/
[Chef solo]: http://docs.opscode.com/chef_solo.html
[Ruby]: http://www.ruby-lang.org/
[Just Enough Ruby for Chef]: http://docs.opscode.com/just_enough_ruby_for_chef.html

### Step 0: Installation

You need to install only [VirtualBox](https://www.virtualbox.org/) and Vagrant, everything else is included in Vagrant distribution (at least it was for me). Just follow the installation instructions.

### Step 1: Configure Vagrant to use Chef solo

Example of `Vagrantfile` contents:

{% highlight ruby linenos %}
Vagrant.configure("2") do |config|
  # ... other configuration options
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "chef/cookbooks"
    chef.add_recipe "recipe1"
    chef.add_recipe "recipe2"
    chef.add_recipe "recipe3"
    # ...
  end
end
{% endhighlight %}

- Line 3 tells Vagrant to use Chef solo as a provisioner.
- Line 4 specifies a relative path to directory with cookbooks. This you can change as you will.
- Lines 5-7 add recipes to run list - if a recipe is not explicitly added here (or included by other recipe) it will not be executed. Names of recipes here are usually the same as name of a cookbook (and it's directory name). Examples: `apache2`, `php`, etc.

**Terminology**:

- **[Cookbook][]** - unit of configuration in Chef. Each cookbook defines a scenario and contains all of the components that are required to support that scenario. Cookbooks contain recipes (one or more) as well as other things. Examples: Arache installation cookbook, MySQL installation cookbook, [ifconfig](http://en.wikipedia.org/wiki/Ifconfig) configuration cookbook, etc.
- **[Recipe][]** - fundamental configuration element which defines an algorithm of how to configure some part of a system. Recipes may include each other.

[Cookbook]: http://docs.opscode.com/essentials_cookbooks.html
[Recipe]: http://docs.opscode.com/essentials_cookbook_recipes.html

### Step 2: Get recipes

Chef community provides you with [lots of ready to use cookbooks][Chef community cookbooks]. In case you need to install some popular software package, you'd first look there. **Note**: not all cookbooks work with Chef solo, and sometimes the only way to know that for sure is to try.

It's important that you download cookbooks and keep them in you repository together with `Vagrantfile`. This ensures that nothing will break when you'll use this repository a year later.

[Chef community cookbooks]: http://community.opscode.com/cookbooks

### Step 3: Write your own resipes

I will show you how to write simplest cookbooks. As a practical example I will use this blog's cookbooks - see [repository](https://github.com/scriptin/scriptin.github.io). If you'll need something more than that, you'll have to read [Chef documentation][].

#### Example #1: Installing Jekyll

[Jekyll][] is a static blog-aware site generator written in [Ruby][]. This blog is built on it.

Jekyll is installed as a Ruby gem and Ruby itself will be installed on VM which is created by Vagrant because Vagrant and Chef require it to run, but there's bunch of other programs which Jekyll uses (e.g. Git) which are not included by default (or must be updated). Thankfully, there's a [build-essential](http://community.opscode.com/cookbooks/build-essential) cookbook which installs or updates these tools. Download this cookbook and extract it into derectory with cookbooks (`./chef/cookbooks/build-essential` in my example), and add a recipe:

{% highlight ruby %}
chef.add_recipe "build-essential"
{% endhighlight %}

Preparation is done, now create a directory `./chef/cookbooks/jekyll` with a `metadata.rb` file containing cookbook [metadata][Metadata], which should be clear by itself:

{% highlight ruby %}
name "jekyll"
description "Installs Jekyll"
maintainer "Dmitry Shpika"
version "0.1"
{% endhighlight %}

Now we need to create an actual recipe which installs Jekyll. Create a subdirectory `./chef/cookbooks/jekyll/recipes` and a file `default.rb` in it:

{% highlight ruby %}
gem_package "jekyll" do
  action :install
end
{% endhighlight %}

`gem_package` is a [resource][Resource] used to manage Ruby gems. It is in fact a Ruby function which accepts gem name as first argument (`"jekyll"`) and Ruby block (`do ... end`). If you're not familiar with Ruby, just consider blocks in a Chef cookbooks as a way to contain configuration options for certain objects (gem in this case). Inside that block we specify an action we want to perform on a gem - installation.

This is it! Just 2 files with 7 <acronym title="Lines of Code">LoC</acronym>.

**Terminology**:

- **[Metadata][]** - Information about cookbook itself, stored in `metadata.rb` file in a base directory of a cookbook.
- **[Resource][]** - a block of code in a recipe defining some action, such as files/directories creation, starting/stopping services, installation of packages and so on.

[Jekyll]: http://jekyllrb.com/
[Metadata]: http://docs.opscode.com/essentials_cookbook_metadata.html
[Resource]: http://docs.opscode.com/resource.html
