#!/bin/sh
echo "Install git"
sudo apt-get install -y git
echo "Deploy project"
cd $HOME
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
echo "Start project"
puma -d
