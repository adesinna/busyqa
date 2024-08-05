module "docker-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  depends_on = [ module.vpc ] # creates this vpc before the instance
  version = "5.6.0"
  name                   = "${var.environment}-docker-instance"
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type_t2
  key_name               = var.instance_keypair # create the key on aws
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.docker-sg.security_group_id]
  user_data = file("${path.module}/docker.sh")
  associate_public_ip_address = true 
  tags = local.common_tags

  root_block_device = [
    {
      volume_type           = "gp2"
      volume_size           = 8
      delete_on_termination = true
    }
  ]
}
