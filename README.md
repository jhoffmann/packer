### Building

```
berks vendor chef/cookbooks
packer build -only=virtualbox-iso -color=false template.json | tee packer.log
```

