# Resource: EC2 Instance
resource "aws_instance" "myinstance" {
  ami = data.aws_ami.ubuntu.id # id of the ami
  instance_type = var.instance_type
  user_data = file("${path.module}/data_script.sh") # file function
  key_name = var.instance_key_pair
  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  tags = {
    "Name" = "myinstance"
  }
}