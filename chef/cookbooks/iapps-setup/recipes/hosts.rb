hostsfile_entry node['network']['default_gateway'] do
  hostname  "host"
  aliases   ["host.#{node['app']['name']}", "parent", "parent.#{node['app']['name']}"]
  action    :create
end
