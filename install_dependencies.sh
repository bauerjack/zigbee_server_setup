#!/bin/bash

# Install Docker

# Reference: https://forums.raspberrypi.com/viewtopic.php?t=320769

echo "sudo apt update"
echo "--------------------------------------------------------------------------------"
sudo apt update
echo "--------------------------------------------------------------------------------"

# This didn't work as I ended up with a version of docker without docker compose
#sudo apt install docker.io

# Followed this guide instead
# https://qbee.io/docs/tutorial-installing-docker-on-a-Raspberry-Pi.html#:~:text=Docker%20Compose%20doesn't%20come,of%20the%20Pi's%20ARM%20architecture.

# First upgrade all my apps
#sudo apt update
#sudo apt upgrade -y

if command -v docker &> /dev/null; then
    echo "Docker is installed and available."
else
    echo "Docker is not installed or not in the PATH."
	# Download and run Docker installation script
	echo "Installing docker from https://get.docker.com"
	curl -fsSL https://get.docker.com -o reference/get-docker.sh
	sudo sh reference/get-docker.sh
fi

# Add 'david' user to the 'docker' group
echo "Add user david to the docker group"
sudo usermod -aG docker david

# verify docker version
docker --version 
docker --version > reference/docker_version.txt

# Install docker-compose Dependencies
echo "Installing docker-compose dependencies"
sudo apt install -y libffi-dev libssl-dev python3 python3-pip

# Install docker-compose 
echo "Installing docker-compose"
sudo apt install -y docker-compose

# Confirm its version
echo "Check docker-compose version"
docker-compose --version
docker-compose --version >> reference/docker_compose_version.txt

