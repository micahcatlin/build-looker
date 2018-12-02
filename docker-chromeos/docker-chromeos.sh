#!/bin/bash

sudo apt-get install docker-ce
sudo cp runc-chromeos /usr/local/bin
sudo cp daemon.json /etc/docker
sudo service docker restart
docker run hello-world
