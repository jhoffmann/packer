# -*- mode: ruby -*-
# vi: set ft=ruby :
PROJECT_NAME = 'dev'
BOX_MEMORY   = '2048'
IP_ADDRESS   = '192.168.3.14'

Vagrant.require_version ">= 1.7.0"

Vagrant.configure('2') do |config|
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.vm.define PROJECT_NAME do |node|
    node.vm.hostname = PROJECT_NAME + '.vm'
    node.vm.network :private_network, ip: IP_ADDRESS
    node.hostmanager.aliases = [
      'si.' + PROJECT_NAME + '.vm',
      'www.' + PROJECT_NAME + '.vm',
      'web.' + PROJECT_NAME + '.vm',
      'stock.' + PROJECT_NAME + '.vm',
      'internal.' + PROJECT_NAME + '.vm',
      'store.' + PROJECT_NAME + '.vm',
      'partners.' + PROJECT_NAME + '.vm',
      'gatekeeper.' + PROJECT_NAME + '.vm',
    ]
  end
  config.vm.provision :hostmanager

  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder '..', '/var/www/htdocs',
    owner: 'vagrant',
    group: 'vagrant',
    mount_options: ['dmode=775,fmode=664']

  config.ssh.username = 'vagrant'
  config.ssh.password = 'vagrant'
  config.ssh.insert_key = 'true'
  config.ssh.forward_agent = true

  config.vm.provider :virtualbox do |vb|
    vb.customize [
      'modifyvm', :id,
      '--memory', BOX_MEMORY,
      '--cpus', '1'
    ]
  end
end
