# Install LAMP
MYSQL_RPM=~/mysql.rpm
wget http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm -O $MYSQL_RPM
rpm -Uvh $MYSQL_RPM
rm $MYSQL_RPM

IUS_RPM=~/ius.rpm
wget http://dl.iuscommunity.org/pub/ius/stable/CentOS/6/x86_64/ius-release-1.0-14.ius.centos6.noarch.rpm -O $IUS_RPM
rpm -Uvh $IUS_RPM
rm $IUS_RPM

yum -y install mysql-community-client
yum -y install memcached libmemcached10 libmemcached10-devel

yum -y install httpd httpd-tools
yum -y install php54 php54-gd php54-xml php54-cli php54-mcrypt php54-pear php54-soap php54-pecl-memcached php54-pdo php54-mysqlnd php54-mbstring php54-bcmath php54-pecl-zendopcache php54-common php54-devel php54-pecl-xdebug

chkconfig --level 2345 memcached on
