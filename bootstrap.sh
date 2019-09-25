#!/usr/bin/env bash

sed -i 's/^mesg n$/tty -s \&\& mesg n/g' /root/.profile
sed -i '/^#.*force_color_prompt=yes/s/^#//' ./.bashrc
echo "ServerName localhost" > /etc/apache2/httpd.conf
mkdir -p /var/www/html
echo "cd /var/www/html/" >> ./.bashrc

printf "%$(tput cols)s\n"|tr " " "="
echo "Starting provisioning (Update list packages)"
printf "%$(tput cols)s\n"|tr " " "="
apt-get update

printf "%$(tput cols)s\n"|tr " " "="
echo "Installing Apache and its modules"
printf "%$(tput cols)s\n"|tr " " "="
apt-get install -y apache2
apt-get install -y php5
#apt-get install -y php5-xdebug

#printf "installing python 3.7.1 ...."
#apt-get update
#apt install software-properties-common
#apt-get install python3.7
#echo "alias python=/usr/bin/python3" >> /home/vagrant/.bashrc
#source ~/home/vagrant/.bashrc
#apt-get install python-pip

#apt-get install -y wget 
#sudo apt install zlib1g-dev
#wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz
#tar -xvf Python-3.7.3.tgz
#sudo apt-get install gcc
#cd Python-3.7.3
#./configure
#make
#sudo make install
#sudo apt-get upgrade python3
#echo "alias python=/usr/bin/python3" >> /home/vagrant/.bashrc
#source ~/home/vagrant/.bashrc


# installing python dev environment
#sudo apt-get install build-essential libssl-dev libffi-dev python-dev -y
#sudo apt install python3-pip

# Setup hosts file
VHOST=$(cat <<EOF
<VirtualHost *:80>
  DocumentRoot "/vagrant/Sites/default"
  ServerName localhost
  <Directory "/vagrant/Sites/default">
    AllowOverride All
    Require all granted
  </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-enabled/000-default
# Enable mod_rewrite
a2enmod rewrite
# Restart apache
service apache2 restart

printf "%$(tput cols)s\n"|tr " " "="
echo "Installing MySql"
printf "%$(tput cols)s\n"|tr " " "="
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password vagrant'
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password vagrant'
apt-get -y install mysql-server libapache2-mod-auth-mysql php5-mysql


printf "%$(tput cols)s\n"|tr " " "="
echo "Configuring Apache for Vagrant"
#printf "%$(tput cols)s\n"|tr " " "="
#if ! [ -L /var/www ]; then
#  rm -rf /var/www/*
#  ln -fs /vagrant /var/www/html
#fi
#sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
a2enmod rewrite
#Configuring XDebug
echo "zend_extension=xdebug.so">/etc/php5/mods-available/xdebug.ini
echo "xdebug.remote_enable = on">>/etc/php5/mods-available/xdebug.ini
echo "xdebug.remote_connect_back = on">>/etc/php5/mods-available/xdebug.ini

service apache2 restart

printf "%$(tput cols)s\n"|tr " " "="
echo "Installing Git and dev tools"
printf "%$(tput cols)s\n"|tr " " "="
apt-get install -y git
apt-get install -y vim 
printf "%$(tput cols)s\n"|tr " " "="
echo "Provisioning completed"
printf "%$(tput cols)s\n"|tr " " "="
