# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.ssh.username = 'vagrant'
  config.ssh.password = 'vagrant'
  config.ssh.insert_key = 'true'
  config.ssh.forward_agent = true

  config.vm.provider :aws do |aws, override|
    aws.region = "us-west-1"
    aws.instance_type = "t2.micro"

    aws.region_config "us-west-1" do |region|
      region.keypair_name = "iapps-dev"
    end

    aws.security_groups = ["sandbox"]
    aws.terminate_on_shutdown = true

    override.ssh.username = "vagrant"
    aws.tags = {
      'Name' => 'iApps Dev Sandbox',
      'vagrant-dev' => 'sandbox'
    }
  end

  config.vm.provider :virtualbox do |vb, override|
    vb.name = 'iapps-dev'

    override.ssh.username = "vagrant"
    vb.customize ["modifyvm", :id, "--memory", "#{1024*1}"]
    vb.customize ["modifyvm", :id, "--cpus",  "1"]

    # Network
    override.vm.network "private_network", type: "dhcp"
  end
end
