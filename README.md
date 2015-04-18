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
packer build -only=virtualbox-iso -color=false template.json | tee packer.log
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
