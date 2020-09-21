#!/bin/sh
apt-get install -y git
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
bundle binstubs puma --path ./sbin
