# Resource: EC2 Instance
resource "aws_instance" "myinstance" {
  ami = "ami-08012c0a9ee8e21c4"
  instance_type = "t2.micro"
  user_data = file("${path.module}/data_script.sh") # file function
  tags = {
    "Name" = "myinstance"
  }
}