#!/bin/bash

sudo yum update -y
sudo yum install git -y
sudo yum install python3 python3-pip -y
git config --global user.name "Username"
git config --global user.email email@email.com
git clone https://github.com/TomasAlric/proz-back-end-saa
cd proz-back-end-saa
pip install -r requirements.txt
python3 server.py