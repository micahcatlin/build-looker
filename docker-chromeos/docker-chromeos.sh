#!/bin/bash

sudo apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   stretch \
   stable"

sudo apt-get update
sudo apt-get install -y docker-ce
sudo cp runc-chromeos /usr/local/bin
sudo cp daemon.json /etc/docker
sudo service docker restart
docker run hello-world
