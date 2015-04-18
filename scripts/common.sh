# Install common development tools
yum -y install git2u vim tig curl

wget http://www.phing.info/get/phing-latest.phar -O /usr/local/bin/phing
chmod 755 /usr/local/bin/phing

wget https://getcomposer.org/composer.phar -O /usr/local/bin/composer
chmod 755 /usr/local/bin/composer

wget https://phar.phpunit.de/phpunit.phar -O /usr/local/bin/phpunit
chmod 755 /usr/local/bin/phpunit
