#!/bin/sh
yc compute instance create \
--name reddit \
--hostname reddit \
--memory=2 \
--network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
--create-boot-disk image-folder-id=standard-images,image-id=fd8obvmvkm7upkdcagve,size=10 \
--metadata serial-port-enable=1 \
--ssh-key ~/.ssh/appuser.pub
