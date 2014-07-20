# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "base"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.network :private_network, ip: "192.168.111.111"

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "chef/cookbooks"
    chef.add_recipe "build-essential"
    chef.add_recipe "apt"
    chef.add_recipe "rvm::system"
    chef.add_recipe "pygments"
    chef.add_recipe "nodejs"
    chef.add_recipe "less"

    chef.json = {
      "base_directory" => "/vagrant", # absolute path to the project shared directory on VM
      "css_directory" => "css",
      "pygments_css_file" => "syntax.css",
      "rvm" => {
        "global_gems" => [
          {"name" => "jekyll"}
        ]
      }
    }
  end
end
