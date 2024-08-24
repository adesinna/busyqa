#!/bin/bash

# Update and install dependencies
sudo apt-get update
sudo apt-get install -y curl

# Install kubectl
KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/arm64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# Verify kubectl installation
kubectl version --client --output=yaml

# Install kind
KIND_VERSION=$(curl -s https://api.github.com/repos/kubernetes-sigs/kind/releases/latest | grep 'tag_name' | cut -d\" -f4)
curl -Lo ./kind "https://kind.sigs.k8s.io/dl/${KIND_VERSION}/kind-linux-arm64"
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Verify kind installation
kind --version

echo "Installation of kubectl and kind on aarch64 architecture is complete!"

