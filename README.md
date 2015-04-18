## Usage

#### Running
```
git clone <this repo>
cd <this repo>
vagrant box add iapps <s3 source>
vagrant up
```

## Development

#### Building
```
berks vendor chef/cookbooks
packer build -only=virtualbox-iso -color=false -force template.json | tee packer.log
```

#### Re-provisioning
```
vagrant ssh
cd /tmp/packer-chef-solo
rsync -irc /var/www/htdocs/packer/chef/cookbooks/ cookbooks-0/
sudo chef-solo --no-color -c solo.rb -j node.json
```

#### Testing
```
vagrant plugin install landrush
vagrant box add iapps boxes/virtualbox/iapps_0.1.box
vagrant init iapps
vagrant up
```

#### Cleanup
```
vagrant destroy -f
vagrant box remove iapps
```

#### Packaging
```
scp boxes/virtualbox/iapps*.box <s3 source>
```
