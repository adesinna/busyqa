# Resource: EC2 Instance
resource "aws_instance" "myinstance" {
  ami = data.aws_ami.amzlinux2.id # id of the ami
  instance_type = var.instance_type_list[0]  # the first value
  user_data = file("${path.module}/data_script.sh") # file function
  key_name = var.instance_key_pair
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
//  count = 2 # this is a meta-argument, it would create 2 instances
  for_each = toset(data.aws_availability_zones.my_az.names) # to set needs to convert all the list into a set
  availability_zone = each.value
  tags = {
//    "Name" = "myinstance-${count.index}" # count index for the name, 0-2

      "Name" = "my-instance-${each.key}"  # in set key=value so, (it is better than count, count gives only number
  }
}