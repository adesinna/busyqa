module "elb-classic" {
  source  = "terraform-aws-modules/elb/aws"
  version = "4.0.2"
  # insert the 4 required variables here
  name = "elb-classic"
  

  subnets         = module.vpc.public_subnets
  security_groups = [module.lb-sg.security_group_id]
  internal        = false

  listener = [
    {
      instance_port     = "80"
      instance_protocol = "http"
      lb_port           = "80"
      lb_protocol       = "http"
    },
    {
      instance_port     = "80"
      instance_protocol = "http"
      lb_port           = "81"
      lb_protocol       = "http"
    },
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  

  tags = local.common_tags

  # ELB attachments
  number_of_instances = length(module.ec2_private)
  instances           = [
    for ec2private in module.ec2_private: 
        ec2private.id
     ] 
}