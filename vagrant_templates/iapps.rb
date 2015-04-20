# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.ssh.username = 'vagrant'
  config.ssh.password = 'vagrant'
  config.ssh.insert_key = 'true'
  config.ssh.forward_agent = true

  config.vm.provider :aws do |aws, override|
    aws.region_config "us-west-1" do |region|
      region.keypair_name = "iapps-dev"
    end
    aws.security_groups = "sg-5fb1013a"
    override.ssh.username = "root"
  end

  config.vm.provider :virtualbox do |vb, override|
    vb.name = 'iapps-dev'

    override.ssh.username = "vagrant"
    vb.customize ["modifyvm", :id, "--memory", "#{1024*1}"]
    vb.customize ["modifyvm", :id, "--cpus",  "1"]
  end
end
