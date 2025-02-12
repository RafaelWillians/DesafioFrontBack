#!/bin/bash

sudo yum update -y
sudo yum install git -y
sudo mkdir -p /var/www/html
sudo chmod -R 755 /var/www/html
git config --global user.name "Username"
git config --global user.email email@email.com
git clone https://github.com/TomasAlric/proz-front-end-saa
cd proz-front-end-saa
sudo mv * /var/www/html
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd