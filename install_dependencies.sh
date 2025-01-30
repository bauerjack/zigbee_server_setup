#!/bin/sh

# Install Docker

# Reference: https://forums.raspberrypi.com/viewtopic.php?t=320769

sudo apt update

# This didn't work as I ended up with a version of docker without docker compose
#sudo apt install docker.io

# Followed this guide instead
# https://qbee.io/docs/tutorial-installing-docker-on-a-Raspberry-Pi.html#:~:text=Docker%20Compose%20doesn't%20come,of%20the%20Pi's%20ARM%20architecture.

# First upgrade all my apps
sudo apt update
sudo apt upgrade -y


# Download and run Docker installation script
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Add 'david' user to the 'docker' group
sudo usermod -aG docker david

# verify docker version
docker --version 
docker --version >> reference/docker_version.txt

# Install docker-compose
sudo apt install -y libffi-dev libssl-dev python3 python3-pip
sudo pip3 install docker-compose

# Confirm its version
docker-compose --version
docker-compose --version >> reference/docker_compose_version.txt

