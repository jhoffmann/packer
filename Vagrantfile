# -*- mode: ruby -*-
# vi: set ft=ruby :

# This has been hardcoded into the pre-built image,
# so please don't try to change it here
TLD="dev.vm"

Vagrant.require_version ">= 1.7.0"

Vagrant.configure(2) do |config|
  config.vm.box = "iapps"

  config.vm.provider :virtualbox do |vb, override|
    override.vm.hostname = TLD

    # Uncomment the following line if you want to give the VM more memory (default is 1GB)
    # vb.customize ["modifyvm", :id, "--memory", "#{1024*2}"]

    # Network
    override.vm.network "private_network", type: "dhcp"
  end

  if Vagrant.has_plugin?('landrush')
    config.landrush.enabled            = true
    config.landrush.tld                = TLD
  end
end
