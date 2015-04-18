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

  puts "Configuring #{app['id']}..."
  # Only setup the vhost if the directory exists
  if File.directory?("#{node['apache']['docroot_dir']}/#{app['id']}/")
    # Add app to apache config
    web_app app['id'] do
      server_name "#{app['id']}.#{node['app']['name']}"
      allow_override 'all'
      docroot "#{node['apache']['docroot_dir']}/#{app['id']}/#{app['docroot']}"
      server_aliases app['server_aliases']
      notifies :restart, resources("service[apache2]"), :delayed
    end
  else
    puts "Skipping vhost config for #{app['id']} as #{node['apache']['docroot_dir']}/#{app['id']} does not exist."
  end
end
