# Base install

sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# Setup our Yum repos
yum -y install scl-utils
yum -y install centos-release-SCL
yum -y install epel-release

# Install the base development tools
yum -y update kernel
yum -y install gcc make gcc-c++ kernel-headers kernel-devel zlib-devel openssl-devel readline-devel sqlite-devel perl wget dkms nfs-utils

# Make ssh faster by not waiting on DNS
echo "UseDNS no" >> /etc/ssh/sshd_config

if [[ $UPDATE  =~ true || $UPDATE =~ 1 || $UPDATE =~ yes ]]; then
    echo "==> Applying updates"
    yum -y update
fi

echo "Rebooting the machine..."
reboot
sleep 999999
