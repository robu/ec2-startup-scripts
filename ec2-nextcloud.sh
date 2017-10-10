#!/bin/bash
# This installs a nextcloud server on an ubuntu EC2 instance.
#
# This is the simplest installation version, with local storage and local sqlite db.
# estimated run-time: 2:25 (two and a half minutes)

# simple log file ends up in /home/ubuntu/nextcloud-install.log

echo "$(date) NEXTCLOUD INSTALLATION START" > /home/ubuntu/nextcloud-install.log
echo "$(date) OS update and upgrade" >> /home/ubuntu/nextcloud-install.log
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq

echo "$(date) necessary packages install" >> /home/ubuntu/nextcloud-install.log
sudo apt-get install apache2 -yq
sudo apt-get install php php-gd libapache2-mod-php sqlite -yq
sudo apt-get install php-sqlite3 php-mysql -yq
sudo apt-get install php-zip php-mbstring php-fdomdocument php-curl -yq
sudo apt-get install php-bz2 php-mcrypt php-imagick php-memcached php-gmp -yq
sudo apt-get install unzip -yq

echo "$(date) restarting apache" >> /home/ubuntu/nextcloud-install.log
sudo service apache2 restart

echo "$(date) downloading nextcloud" >> /home/ubuntu/nextcloud-install.log
wget https://download.nextcloud.com/server/releases/latest.zip
sudo mv latest.zip /var/www/html
cd /var/www/html
echo "$(date) unpacking nextcloud" >> /home/ubuntu/nextcloud-install.log
sudo unzip -q latest.zip

sudo mkdir -p /var/www/html/nextcloud/data
sudo chown -R www-data:www-data /var/www/html/nextcloud/
sudo chmod 750 /var/www/html/nextcloud/data

cd /var/www/html/nextcloud

# at this point, nextcloud is installed and can be accessed via http,
# however, the final setup steps can either be done on the web interface,
# or from the nextcloud cli, as follows here:

# get public IP from the "instance metadata service" (cf https://goo.gl/1ZNoPN)
MYIP=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)

# the simplest install, using the default sqlite3 database
echo "$(date) final config" >> /home/ubuntu/nextcloud-install.log
sudo -u www-data php occ maintenance:install \
  --admin-user "admin" --admin-pass "password"

# mysql version:
#  sudo -u www-data php occ maintenance:install \
#    --database "mysql" --database-name "nextcloud" \
#    --database-user "root" --database-pass "password"
#    --admin-user "admin" --admin-pass "password"

sudo -u www-data php occ config:system:set trusted_domains 1 --value=$MYIP

echo "$(date) NEXTCLOUD INSTALLATION COMPLETE" >> /home/ubuntu/nextcloud-install.log
echo "$(date) Visit http://$MYIP/nextcloud to use the web interface" >> /home/ubuntu/nextcloud-install.log
