# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.require_version ">= 1.7.0"

Vagrant.configure(2) do |config|
  config.vm.box = "iapps"

  # Network
  config.vm.network "private_network", type: "dhcp"

  if Vagrant.has_plugin?('landrush')
    config.landrush.enabled            = true
    config.landrush.tld                = config.vm.hostname
  end

  # Git
  if File.exists?(File.join(Dir.home, '.gitconfig')) then
    config.vm.provision :file do |file|
      file.source      = '~/.gitconfig'
      file.destination = '/home/vagrant/.gitconfig'
    end
  end

  # Composer
  if File.exists?(File.join(Dir.home, '.composer/auth.json')) then
    config.vm.provision :file do |file|
      file.source      = '~/.composer/auth.json'
      file.destination = '/home/vagrant/.composer/auth.json'
    end
  end
end
