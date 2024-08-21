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
  default = "terra-demo"
}

# list type variable

variable "instance_type_list" {
  description = "ec2 types"
  type = list(string)
  default = ["t3.micro", "t2.micro"]
}


variable "instance_type_map" {
  description = "Ec2 env"
  type = map(string)
  default = {
    "dev" = "t3.micro"
    "prod" = "t2.micro"
  }
}
