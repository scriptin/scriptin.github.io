# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "base"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  config.vm.network :private_network, ip: "192.168.111.111"

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "chef/cookbooks"
    chef.add_recipe "build-essential"
    chef.add_recipe "pygments"
    chef.add_recipe "jekyll"

    chef.json = {
      "base_directory" => "/vagrant", # absolute path to the projectq shared directory on VM
      "css_directory" => "css",
      "pygments_css_file" => "syntax.css"
    }
  end
end
