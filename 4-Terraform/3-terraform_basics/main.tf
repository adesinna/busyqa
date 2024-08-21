# Terraform Settings Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      #version = "~> 3.21" # Optional but recommended in production
    }
  }
}

# Provider Block
provider "aws" {
  profile = "default" # AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials
  region  = "us-west-1"
}

# Resource Block
resource "aws_instance" "myfirstinstance" {
  ami           = "ami-08012c0a9ee8e21c4" # ubuntu instance in the region
  instance_type = "t2.micro"
}