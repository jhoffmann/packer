## Usage

#### Running
```
git clone <this repo>
cd <this repo>
vagrant box add iapps <s3 source>
vagrant plugin install landrush
vagrant up
```

## Development

#### Building

Run `berks vendor chef/cookbooks` to download any dependant cookbooks, which will be shared with the virtual machine
during provisioning.  After that, you can build a new image using:
```
packer build -only=virtualbox-iso -color=false -force template.json | tee packer.log
```

#### Re-provisioning

If you make changes to a Chef recipe or attributes file, and want to test the changes inside a running virtual machine without
having to destory and re-build, you can try something like this:
```
vagrant ssh
cd /tmp/packer-chef-solo
rsync -irc /var/www/htdocs/packer/chef/cookbooks/ cookbooks-0/  # Your paths may differ
sudo chef-solo --no-color -c solo.rb -j node.json
```

#### Testing
After the build is finished, you should test it locally before uploading it to Amazon.
```
vagrant box remove iapps
vagrant box add iapps boxes/virtualbox/iapps_0.1.box
vagrant up
```

#### Packaging
```
aws s3 sync boxes s3://vagrant-boxes-sugar1
```
