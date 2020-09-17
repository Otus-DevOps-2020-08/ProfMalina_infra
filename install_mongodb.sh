#!/bin/sh
echo "Add key"
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
sudo apt-get update
echo "Install MongoDB"
sudo apt-get install -y mongodb-org
echo "Start and enable servise Mongod"
sudo systemctl start mongod
sudo systemctl enable mongod
