# this allows you to get outside information like AMIs
data "aws_ami" "ubuntu" {
  most_recent      = true
  owners           = ["099720109477"] # the owner id of the ami when you search in amis

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"] #copy the ami id and search for it in AMIs to get the name
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}