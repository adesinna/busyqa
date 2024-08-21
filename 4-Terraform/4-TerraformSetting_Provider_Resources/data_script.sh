#!/bin/bash
# Instance Identity Metadata Reference - https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-identity-documents.html

# Update the instance
sudo apt update -y
sudo apt upgrade -y

# Install Apache HTTP Server
sudo apt install -y apache2

# Enable Apache to start on boot and start the service
sudo systemctl enable apache2
sudo systemctl start apache2

# Create a simple HTML file
echo '<h1>Welcome to StackSimplify - APP-1</h1>' | sudo tee /var/www/html/index.html

# Create a directory and another HTML file
sudo mkdir /var/www/html/app1
echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to Stack Simplify - APP-1</h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/app1/index.html

# Retrieve EC2 instance metadata
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/dynamic/instance-identity/document -o /var/www/html/app1/metadata.html

# AWS Documentation to retrieve EC2 Instance Data
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instancedata-data-retrieval.html
