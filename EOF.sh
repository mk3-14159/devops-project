#!/bin/bash

# updating for git
echo "updating instance ... "
sudo apt update -y
echo "updating instance ... done"

# installing git
echo "installing git ... "
sudo apt install git -y
echo "installing git ... done"

# installing git essentials
echo "installing docker dependencies ..."
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y
echo "installing docker dependencies ... done"

# installing docker on gpg key
echo "adding docker's official gpg key ..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "adding docker's official gpg key ... done"

# creating repository for docker
echo "setting up the repository ..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo "setting up the repository ... done"

# installing docker engine
echo "installing docker enginer ..."
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
echo "installing docker enginer ... done"

# checking docker version
echo "docker version :"
which docker

# install jenkins

