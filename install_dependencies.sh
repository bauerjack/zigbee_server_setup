#!/bin/bash

# Install Docker

# Reference: https://forums.raspberrypi.com/viewtopic.php?t=320769

sudo apt update

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
	curl -fsSL https://get.docker.com -o get-docker.sh
	sudo sh get-docker.sh
fi

# Add 'david' user to the 'docker' group
sudo usermod -aG docker david

# verify docker version
docker --version 
docker --version > reference/docker_version.txt

# Install docker-compose Dependencies
echo "Installing docker-compose dependencies"
sudo apt install -y libffi-dev libssl-dev python3 python3-pip

# Install docker-compose Dependencies
# The following step didn't work on raspbian
# Got an error saying that I needed to use a python virtualenv intead
#sudo pip3 install docker-compose

# Create Python venv 
# Reference: https://www.freecodecamp.org/news/how-to-setup-virtual-environments-in-python/
# Reference: https://www.raspberrypi.com/documentation/computers/os.html#python-on-raspberry-pi
PYTHON_VENV_FOLDER=./venv
if [ ! -d "$PYTHON_VENV_FOLDER" ]; then
	echo "Creating Python Virtual Env in: $PYTHON_VENV_FOLDER"
	mkdir -p "$PYTHON_VENV_FOLDER"
	echo "Virtual Environment created in: $PYTHON_VENV_FOLDER"
	python3 -m venv $PYTHON_VENV_FOLDER
else
	echo "Found pre-existing virtual Environment in: $PYTHON_VENV_FOLDER"
fi

echo "Invoking Python Virtual Environment: $PYTHON_VENV_FOLDER"
echo "source $PYTHON_VENV_FOLDER/bin/activate"
source $PYTHON_VENV_FOLDER/bin/activate

pip3 list | tee pip3_before.txt
pip3 install docker-compose | tee docker-compose install
pip3 list | tee pip3_after.txt

# Confirm its version
#docker-compose --version
#docker-compose --version >> reference/docker_compose_version.txt

