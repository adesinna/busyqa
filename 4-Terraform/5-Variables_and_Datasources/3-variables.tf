# AWS region

variable "aws_region" {
  description = "Region where aws is created"
  type = string
  default = "us-west-1"

}
# Instance type
variable "instance_type" {
  description = "Ec2 instance type"
  type = string
  default = "t2.micro"

}

# key pair

variable "instance_key_pair" {
  description = "The key pair"
  type = string
  default = "kube-demo"
}