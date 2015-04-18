# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.ssh.username = 'vagrant'
  config.ssh.password = 'vagrant'
  config.ssh.insert_key = 'true'
  config.ssh.forward_agent = true

  config.vm.provider :virtualbox do |vb, override|
    vb.name = 'iapps-dev'
    vb.vm.synced_folder ".", "/vagrant", disabled: true
    vb.vm.synced_folder '..', '/var/www/htdocs',
      owner: 'vagrant',
      group: 'vagrant',
      mount_options: ['dmode=775,fmode=664']

    vb.customize ["modifyvm", :id, "--memory", "#{1024*1}"]
    vb.customize ["modifyvm", :id, "--cpus",  "1"]
  end
end
