# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder '..', '/var/www/htdocs',
    owner: 'vagrant',
    group: 'vagrant',
    mount_options: ['dmode=775,fmode=664']

  config.ssh.username = 'vagrant'
  config.ssh.password = 'vagrant'
  config.ssh.insert_key = 'true'
  config.ssh.forward_agent = true

  config.vm.hostname = 'dev.vm'

  config.vm.provider :virtualbox do |vb|
    vb.customize [
      'modifyvm', :id,
      '--memory', '2048',
      '--cpus', '1'
    ]
  end
end
