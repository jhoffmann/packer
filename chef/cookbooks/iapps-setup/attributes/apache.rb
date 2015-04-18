default['apache']['user']        = 'vagrant'
default['apache']['group']       = 'vagrant'
default['apache']['docroot_dir'] = '/var/www/htdocs'

if File.exists?('local.rb')
  include_attribute 'iapps-setup::local'
end
