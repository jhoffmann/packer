# Keep chef from trying to install the PHP 5.3 rpm's that come with CentOS 6.5
override['php']['ini']['cookbook'] = 'iapps-setup'

# These get added to the end of the php.ini file, so you can add whatever you need here
default['php']['conf_dir'] = '/etc'
default['php']['directives']['date.timezone']        = 'PST8PDT'
default['php']['directives']['session.save_path']    = 'localhost:11211'
default['php']['directives']['session.save_handler'] = 'memcached'
default['php']['directives']['error_log']            = "#{node['apache']['docroot_dir']}/php_errors.log"

# These are the suggested values for running Sugar7
default['php']['directives']['memory_limit']         = '512M'
default['php']['directives']['post_max_size']        = '50M'
default['php']['directives']['upload_max_filesize']  = '50M'

if File.exists?('local.rb')
  include_attribute 'iapps-setup::local'
end
