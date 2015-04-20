## Usage

#### Why?

This virtual machine already contains a complete LAMP stack, pre-configured to run the iApps suite of sites:
- CentOS 6.5 (the same as IT uses in the VPC)
- apache
- php 5.4 (matches our jenkins environment)
- memcached server for php sessions
- mysql client

Customized configuration files:
- php.ini
- apache vhosts (for sugar, gatekeeper, internal)
- tiny dns server for host/VM communications (*.dev.vm)
- /etc/hosts entry on the VM that points to the host (host, host.dev.vm, parent, parent.dev.vm)

Additional tools for testing/development:
- composer
- phpunit
- phing
- npm, grunt, bower

#### Host requirements

Because we want to limit the memory the VM uses (to free it up for hogs like PHPStorm or MS Excel), you still need to run elasticsearch and the mysql server on your host machine.  You'll also need `vagrant` and `virtualbox` installed to bring the machine online.
```
$ brew install caskroom/cask/brew-cask

$ brew cask install vagrant virtualbox
$ brew cask install java

$ brew install mysql
$ brew install elasticsearch
```

You'll also want our custom `~/.my.cnf` config file, and instructions on downloading and importing the relevant databases are documented elsewhere.

#### Running

You want to run this from a directory near your other iApps repos.  So for example, if you keep all of your code in `~/src`, and you have `~/src/si, ~/src/gatekeeper` etc, then:
```
$ cd ~/src
$ mkdir packer; cd packer
$ wget https://gist.githubusercontent.com/jhoffmann/8420473db2148c0c7ba7/raw/Vagrantfile
$ vagrant plugin install landrush
$ vagrant up
```

The reason for this, is that we'll mount `..` to `/var/www/htdocs` inside the virtual machine, which means all of our locally checked out code now becomes the docroot's for our various Apache virtual hosts.

If everything works, you should be able to visit http://si.dev.vm in your browser!

## Development

#### Building

```
$ brew cask install chefdk packer
```

Run `berks vendor chef/cookbooks` to download any dependant cookbooks, which will be shared with the virtual machine
during provisioning.  After that, you can build a new image using:
```
$ packer build -only=virtualbox-iso -color=false -force template.json | tee packer.log
```

#### Re-provisioning

If you make changes to a Chef recipe or attributes file, and want to test the changes inside a running virtual machine without
having to destory and re-build, you can try something like this:
```
$ vagrant ssh
$ cd /tmp/packer-chef-solo
$ rsync -irc /var/www/htdocs/packer/chef/cookbooks/ cookbooks-0/  # Your paths may differ
$ sudo chef-solo --no-color -c solo.rb -j node.json
```

#### Testing
After the build is finished, you should test it locally before uploading it to Amazon.
```
$ vagrant box remove iapps
$ vagrant box add iapps boxes/virtualbox/iapps_0.1.box
$ vagrant up
```

#### Packaging
Assuming you have your `~/.aws` setup by running `aws configure`, which comes from the Homebrew `awscli` package.
```
$ aws s3 sync --dryrun boxes s3://iapps-dev-boxes
$ aws s3 sync boxes s3://iapps-dev-boxes
```
