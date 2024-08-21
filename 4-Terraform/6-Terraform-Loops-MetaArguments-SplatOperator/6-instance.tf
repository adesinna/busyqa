# Resource: EC2 Instance
resource "aws_instance" "myinstance" {
  ami = data.aws_ami.amzlinux2.id # id of the ami
  instance_type = var.instance_type_list[0]  # the first value
  user_data = file("${path.module}/data_script.sh") # file function
  key_name = var.instance_key_pair
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  count = 2 # this is a meta-argument, it would create 5 instances
  tags = {
    "Name" = "myinstance-${count.index}" # count index for the name, 0-4
  }
}

# Resource: EC2 Instance
resource "aws_instance" "my_instance_2" {
  ami = data.aws_ami.amzlinux2.id # id of the ami
  instance_type = var.instance_type_map["dev"]  # the key for the map
  user_data = file("${path.module}/data_script.sh") # file function
  key_name = var.instance_key_pair
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  count = 2 
  tags = {
    "Name" = "myinstance-${count.index}"
  }
}