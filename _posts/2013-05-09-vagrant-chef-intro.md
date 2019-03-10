---
title: Minimal practical introduction to Vagrant and Chef
layout: post
---
First time I tried to use [Vagrant][] with [Chef][] ([solo version][Chef solo]) as a [provisioner](http://docs.vagrantup.com/v2/provisioning/index.html) I got stuck with too much irrelevant information on the topic. So here is the short introduction to get you started. I wanted it to be as simple as possible, so maybe you'll find some of my explanations a bit redundant.

Before reading this post:

- Make sure you know why to use Vagrant.
- Read some [Vagrant documentation][] - it's simple enough, so I decided not include it here. Feel free to skip sections about provisioners other than Chef solo and other stuff you think you will not need.
- Make sure you know why to use Chef (in short: it's better than tons of bash scripts) and what is [Chef solo][] (in short: it is a standalone open source version of Chef).
- If you don't know [Ruby][] at all, read [Just Enough Ruby for Chef][] from [Chef documentation][].

[Vagrant]: http://www.vagrantup.com/
[Vagrant documentation]: http://docs.vagrantup.com/v2/
[Chef]: http://www.getchef.com/
[Chef documentation]: http://docs.getchef.com/
[Chef solo]: http://docs.getchef.com/chef_solo.html
[Ruby]: http://www.ruby-lang.org/
[Just Enough Ruby for Chef]: http://docs.getchef.com/just_enough_ruby_for_chef.html

## Step 0: Installation

You need to install only [VirtualBox](https://www.virtualbox.org/) and Vagrant, everything else is included in Vagrant distribution (at least it was for me). Just follow the [installation instructions](http://docs.vagrantup.com/v2/installation/index.html).

## Step 1: Configure Vagrant to use Chef solo

Example of `Vagrantfile` contents:

```ruby
Vagrant.configure("2") do |config|
  # ... other configuration options
  config.vm.provision :chef_solo do |chef| # A
    chef.cookbooks_path = "chef/cookbooks" # B
    chef.add_recipe "recipe1" # C
    chef.add_recipe "recipe2"
    chef.add_recipe "recipe3"
    # ...
  end
end
```

- (A) Tell Vagrant to use Chef solo as a provisioner.
- (B) Specifies a relative path to directory with cookbooks. This you can change as you will.
- (C) Add recipes to run list. If a recipe is not explicitly added here (or included by other recipe) it will not be executed. Names of recipes here are usually the same as name of a cookbook (and it's directory name). Examples: `apache2`, `php`, etc.

**Terminology**:

- **[Cookbook][]** - unit of configuration in Chef. Each cookbook defines a scenario and contains all of the components that are required to support that scenario. Cookbooks contain recipes (one or more) as well as other things which are out of scope of this post. Examples: [Apache](https://supermarket.getchef.com/cookbooks/apache2), [MySQL](https://supermarket.getchef.com/cookbooks/mysql), [iptables](https://supermarket.getchef.com/cookbooks/iptables), etc.
- **[Recipe][]** - fundamental configuration element which defines an algorithm of how to configure some part of a system. Recipes may execute another recipes.

[Cookbook]: http://docs.getchef.com/essentials_cookbooks.html
[Recipe]: http://docs.getchef.com/essentials_cookbook_recipes.html

## Step 2: Get recipes

Chef community provides you with [lots of cookbooks][Chef cookbooks]. In case you need to install some popular software package, you'd first look there. **Note**: not all cookbooks work with Chef solo, and sometimes the only way to know that for sure is to try.

It's important that you download cookbooks and keep them in you repository together with `Vagrantfile`. This gives you some guarantees that your project will not break when you'll try to build it a long time after you created it, because cookbooks are likely to change over time.

[Chef cookbooks]: https://supermarket.getchef.com/cookbooks

## Step 3: Write your own recipes

I will show you how to write simplest cookbooks. As a practical example I will use this blog's cookbooks - see [repository](https://github.com/scriptin/scriptin.github.io). If you'll need something more than that, you'll have to read [Chef documentation][].

### Example 1: Installing Jekyll

[Jekyll][] is a static blog-aware site generator written in [Ruby][]. This blog is built on it.

Jekyll is installed as a Ruby gem and Ruby itself will be installed on VM which is created by Vagrant, because Vagrant and Chef require it to run, but there's bunch of other programs which Jekyll uses (e.g. Git) which are not included by default (or must be updated). Thankfully, there's a [build-essential](https://supermarket.getchef.com/cookbooks/build-essential) cookbook which installs or updates these tools. Download this cookbook and extract it into the directory with cookbooks (`./chef/cookbooks` in my example, so the cookbook must be in `./chef/cookbooks/build-essential`), and add a recipe:

```ruby
chef.add_recipe "build-essential"
```

Preparation is done, now create a directory `./chef/cookbooks/jekyll` with a `metadata.rb` file containing cookbook [metadata][Metadata], which should be clear by itself:

```ruby
name "jekyll"
description "Installs Jekyll"
maintainer "Dmitry Shpika"
version "0.1"
```

Now we need to create an actual recipe which installs Jekyll. Create a subdirectory `./chef/cookbooks/jekyll/recipes` and a file `default.rb` in it:

```ruby
gem_package "jekyll" do
  action :install
end
```

`gem_package` is a [resource][Resource] used to manage Ruby gems. It is in fact a Ruby function which accepts gem name as first argument (`"jekyll"`) and Ruby block (`do ... end`). If you're not familiar with Ruby, just consider blocks in a Chef cookbooks as a way to contain configuration options for certain objects (gem in this case). Inside that block we specify an action we want to perform on a gem - installation.

This is it! Just 2 files with 7 <acronym title="Lines of Code">LoC</acronym>.

**Terminology**:

- **[Metadata][]** - Information about cookbook itself, stored in `metadata.rb` file in a base directory of a cookbook.
- **[Resource][]** - a block of code in a recipe defining some action, such as files/directories creation, starting/stopping services, installation of packages and so on.

[Jekyll]: http://jekyllrb.com/
[Metadata]: http://docs.getchef.com/essentials_cookbook_metadata.html
[Resource]: http://docs.getchef.com/resource.html

### Example 2: Installing Pygments and generating CSS file for syntax highlighting

Now let's try something more involved and look at more Chef resources.

[Pygments][] is a syntax highlighter written in Python and [used by Jekyll](http://jekyllrb.com/docs/posts/).

First let's create `./chef/cookbooks/pygments` directory and `metadata.rb` in it:

```ruby
name "pygments"
description "Installs python-pygments"
maintainer "Dmitry Shpika"
version "0.1"
```

Then, analogously to previous example, `./chef/cookbooks/pygments/recipes/default.rb`:

```ruby
package "python-pygments" do
  action :install
end
```

This installs Pygments (but this time with `package` resource, because this is not a gem) and we may stop here, but just for the sake of learning let's make it so Pygments will generate CSS file with default syntax highlighting rules, but only if it's not already there. All code snippets below must go into `./chef/cookbooks/pygments/recipes/default.rb`.

If you're not familiar with Ruby, here's the time to seriously go and read that [Just Enough Ruby for Chef][] article. In fact, I will go beyond that's described there and will do my best to explain what I do, so bare with me. I've actually learned Ruby just before I started using Vagrant, Chef solo and Jekyll.

First thing we need is to tell Pygments where we want our CSS file to be. By default, Vagrant maps the project root directory on your system (this is where `Vagrantfile` is) to `/vagrant` directory on VM it builds. Let's say we want this CSS to go into `/vagrant/css/syntax.css`. From terminal, it is just this command:

    pygmentize -S default -f html > /vagrant/css/syntax.css

But Chef doesn't know about Vagrant default directory. The way to tell it is to use `json` property of Chef object in `Vagrantfile`:

```ruby
Vagrant.configure("2") do |config|
  # ...
  config.vm.provision :chef_solo do |chef|
    # ...
    chef.json = {
      "css_directory" => "/vagrant/css",
      "pygments_css_file" => "syntax.css"
    }
  end
end
```

To create a directory in Chef recipe, we must use [`directory` resourse](http://docs.getchef.com/resource_directory.html) like so:

```ruby
directory "/some/dir" do
  owner "root"
  group "root"
  mode 00755
  action :create
end
```

In our case, we better first check if directory name is actually present and only then use it:

```ruby
if node["css_directory"]
  directory node["css_directory"] do
    # default owner/group permissions are OK, so we omit it
    action :create
  end
end
```

`node` is an object you can use in your recipes, it contains attributes of the system under configuration. It is called "node" because full version of Chef uses client-server architecture to configure multiple systems ("nodes"), which may be virtual or physical machines connecting to a single server.

`node["some_property"]` is a way to access some property we set in `chef.json` above. Properties can be set in different ways, but we'll stick with that.

Next, we finally need to generate the damn CSS. But to do that we need to check if the file name is given (same as with CSS directory) and that file is not already there. Here's the code:

```ruby
if node["css_directory"] && node["pygments_css_file"] # A
  directory node["css_directory"] do
    # default owner/group permissions are OK, so we omit it
    action :create
  end

  pygments_css_file = File.join(node["css_directory"], node["pygments_css_file"]) # B

  execute "generate-pygments-css" do # C
    command "pygmentize -S default -f html > #{pygments_css_file}"
    not_if { File.size?(pygments_css_file) }
    action :nothing
  end

  file pygments_css_file do # D
    action :create_if_missing
    notifies :run, "execute[generate-pygments-css]", :immediately
  end
end
```

- (A) Check that both `node["css_directory"]` and `node["pygments_css_file"]` values are present.
- (B) Concatenate directory path with file name in a safe way using Ruby's `File` module and store it in `pygments_css_file` variable.
- (C) Create, but not execute right away, a task of generating a CSS file.
  - Using `execute` resource, give task a name `"generate-pygments-css"` to use later.
  - Specify a command as a string. Note we use Ruby's string interpolation mechanism to inject the file name.
  - `not_if`: do not execute the task if file is not empty - `File.size?()` checks exactly that.
  - `action :nothing`: do not execute task right now, just create it and save for later.
- (D) Create an empty file if there isn't one and then execute a task created just before.
  - Use `file` resource with a file name - similar to `directory` resource.
  - Notify another resource to perform some action. In this case we notifying the task we created before (`"execute[generate-pygments-css]"` is a string which acts as a reference to the task) to perform `:run` action right now (`:immediately`).

We've used two new resources: `file` and `execute`. I recommend you to read [documentation about resources][Resource] to understand that they do. There's a lot of resources which you will constantly use in your recipes.

Here is the full version of `./chef/cookbooks/pygments/recipes/default.rb`:

```ruby
package "python-pygments" do
  action :install
end

if node["css_directory"] && node["pygments_css_file"]
  directory node["css_directory"] do
    # default owner/group permissions are OK, so we omit it
    action :create
  end

  pygments_css_file = File.join(node["css_directory"], node["pygments_css_file"])

  execute "generate-pygments-css" do
    command "pygmentize -S default -f html > #{pygments_css_file}"
    not_if { File.size?(pygments_css_file) }
    action :nothing
  end

  file pygments_css_file do
    action :create_if_missing
    notifies :run, "execute[generate-pygments-css]", :immediately
  end
end
```

It is bigger than a previous example, but yet small and readable enough. We're done.

[Pygments]: http://pygments.org/

## Further reading

- [How to create a virtual host using Vagrant and Chef solo?](http://stackoverflow.com/q/16568924/484666) - <acronym title="Stack Overflow">SO</acronym> question with my answer.
- [Foodcritic](http://acrmp.github.io/foodcritic/) - lint tool for Chef cookbooks. Page contains a list of good/bad examples of code you would typically use in your cookbooks.
- [Vagrant/Chef tutorial by Alex Dergachev](https://gist.github.com/dergachev/3866825) - covers concepts of databags and VM packaging
