# Ruby 2.0 dependencies
yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison iconv-devel

# Install rvm
curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
curl -L get.rvm.io | bash -s stable

# This normally gets run when we login
source /etc/profile.d/rvm.sh

# Now install ruby 2.0, which is needed for chef-solo
rvm install 2.0.0
rvm use 2.0.0 --default
