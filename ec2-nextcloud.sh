#!/bin/bash

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq

sudo apt-get install apache2 -yq
sudo apt-get install php php-gd libapache2-mod-php sqlite php-sqlite3 -yq
sudo apt-get install php-zip php-mbstring php-fdomdocument php-curl -yq
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
