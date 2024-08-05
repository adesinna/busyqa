#!/bin/bash

# Update the package database
sudo apt-get update

# Install necessary packages
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the stable repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package database again
sudo apt-get update

# Install Docker Engine
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Verify Docker installation
sudo docker --version

# Optional: Manage Docker as a non-root user
sudo groupadd docker
sudo usermod -aG docker $USER
sudo usermod -aG docker ubuntu # incase it is not ubuntu that runs it


echo "Docker installation completed. Log out and log back in to manage Docker as a non-root user."