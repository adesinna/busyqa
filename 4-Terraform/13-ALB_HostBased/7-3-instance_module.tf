module "ec2_public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  depends_on = [ module.vpc ] # creates this vpc before the instance
  version = "5.6.0"
  name                   = "${var.environment}-BastionHost"
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair # create the key on aws
  subnet_id              = module.vpc.public_subnets[0] 
  vpc_security_group_ids = [module.sg-bastion-server.security_group_id]
  tags = local.common_tags
}


module "ec2_private_app1" {
  depends_on = [ module.vpc ] # VERY VERY IMPORTANT else userdata webserver provisioning will fail
  source  = "terraform-aws-modules/ec2-instance/aws"
 
  version = "5.6.0"
  
  name                   = "${var.environment}-app1"
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  user_data = file("${path.module}/app1-install.sh")
  tags = local.common_tags


  vpc_security_group_ids = [module.sg-private-ec2.security_group_id]
  for_each = toset(["0", "1"]) # this means set 0,1 to first and second
  subnet_id =  element(module.vpc.private_subnets, tonumber(each.key))  # give each on subnet
}


module "ec2_private_app2" {
  depends_on = [ module.vpc ] # VERY VERY IMPORTANT else userdata webserver provisioning will fail
  source  = "terraform-aws-modules/ec2-instance/aws"
 
  version = "5.6.0"
  
  name                   = "${var.environment}-app2"
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  user_data = file("${path.module}/app2-install.sh")
  tags = local.common_tags


  vpc_security_group_ids = [module.sg-private-ec2.security_group_id]
  for_each = toset(["0", "1"]) # this means set 0,1 to first and second
  subnet_id =  element(module.vpc.private_subnets, tonumber(each.key))  # give each on subnet
}





