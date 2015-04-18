include_recipe 'apache2'
include_recipe 'apache2::mod_rewrite'
include_recipe 'apache2::mod_autoindex'

apps = []
begin
  apps = data_bag("apps")
rescue
  puts "Unable to load apps data bag."
end

# Configure apps
apps.each do |name|
  app = data_bag_item("apps", name)

  directory "#{node['apache']['docroot_dir']}/#{app['id']}/#{app['docroot']}" do
    mode '0755'
    recursive true
    owner node['apache']['user']
    group node['apache']['group']
  end

  puts "Configuring #{app['id']}.#{node['app']['name']}..."
  # Add app to apache config
  web_app app['id'] do
    server_name "#{app['id']}.#{node['app']['name']}"
    allow_override 'all'
    docroot "#{node['apache']['docroot_dir']}/#{app['id']}/#{app['docroot']}"
    server_aliases app['server_aliases']
    notifies :restart, resources("service[apache2]"), :delayed
  end
end

apache_module 'php' do
  filename "libphp5.so"
  module_path "#{node['apache']['dir']}/modules/#{params[:filename]}"
  identifier "php5_module"
  conf true
end
