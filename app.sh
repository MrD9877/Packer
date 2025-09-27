#!/bin/bash

sleep 30

sudo yum update -y

sudo yum install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_22.x | sudo -E bash -
sudo yum install -y nodejs

sudo yum install -y git

cd ~/ && git clone https://github.com/MrD9877/packer_image_test_node_server.git
cd ~/packer_image_test_node_server && npm i && npm run build


sudo mv /tmp/packer.service /etc/systemd/system/packer.service
sudo systemctl enable packer.service
sudo systemctl start packer.service