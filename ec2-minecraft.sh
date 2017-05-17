#!/bin/bash
# this is for the Amazon Linux AMI. Note that port 25565 must be added to the security group used.
#
# instructions copied from http://tsmonaghan.com/set-minecraft-server-aws-cloud-complete-guide-87
# to use, put this in the "user data" field when creating a new EC2 instance:
# curl https://raw.githubusercontent.com/robu/ec2-startup-scripts/master/ec2-minecraft.sh | bash

sudo yum update -y
mkdir minecraft
cd minecraft
wget `curl https://minecraft.net/en-us/download/server | sed -n 's/.*href="\([^"]*\).*/\1/p' | grep https://s3.amazonaws.com/Minecraft.Download`
ln -s mine* minecraft_server.jar

# this will return an error, but also create the eula.txt that we need to change:
sudo java -Xmx1024M -jar minecraft_server.jar nogui

sudo chmod a+rw eula.txt
echo "eula=true" > eula.txt
sudo chmod go-w eula.txt

screen sudo java -Xmx1024M -jar minecraft_server.jar nogui
