module "docker-sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.2"

  name        = "docker-sg"
  description = "Security group for the control plane"
  vpc_id      = module.vpc.vpc_id

  tags = local.common_tags


  # Ingress and Egress Rules
   ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "142.189.98.182/32" # my present ip
      description = "Allow SSH from my IP"
    },

     {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0" # my present ip
      description = "Allow 80 from my anywhere"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all outbound traffic"
    }
  ]

}
