#!/bin/bash
# This is for the Amazon Linux AMI. Note that port 25565 must be added to the security group used.
#
# Instructions copied from http://tsmonaghan.com/set-minecraft-server-aws-cloud-complete-guide-87
# to use, paste this entire script into the "user data" field when creating a new EC2 instance.
#
# To access the server console when running, log into the EC2 instance and run "screen -r".

sudo yum update -y
mkdir minecraft
cd minecraft
curl -O `curl https://minecraft.net/en-us/download/server | sed -n 's/.*href="\([^"]*\).*/\1/p' | grep https://s3.amazonaws.com/Minecraft.Download`
ln -s mine* minecraft_server.jar

echo "eula=true" > eula.txt

screen -S minecraft -d -m java -Xmx1024M -jar minecraft_server.jar nogui
