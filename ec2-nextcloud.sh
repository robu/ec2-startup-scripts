#!/bin/bash
# This installs a nextcloud server on an ubuntu EC2 instance.
#
# This is the simplest installation version, with local storage and local sqlite db.

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq

sudo apt-get install apache2 -yq
sudo apt-get install php php-gd libapache2-mod-php sqlite -yq
sudo apt-get install php-sqlite3 php-mysql -yq
sudo apt-get install php-zip php-mbstring php-fdomdocument php-curl -yq
sudo apt-get install php-bz2 php-mcrypt php-imagick php-memcached php-gmp -yq
sudo apt-get install unzip -yq

sudo service apache2 restart

wget https://download.nextcloud.com/server/releases/latest.zip
sudo mv latest.zip /var/www/html
cd /var/www/html
sudo unzip -q latest.zip

sudo mkdir -p /var/www/html/nextcloud/data
sudo chown www-data:www-data /var/www/html/nextcloud/data
sudo chmod 750 /var/www/html/nextcloud/data

cd /var/www/html/nextcloud
sudo chown www-data:www-data config apps
