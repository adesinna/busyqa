module "application-lb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.9.0"

  name    = "application-lb"
  vpc_id  =  module.vpc.vpc_id
  subnets =  module.vpc.public_subnets
  security_groups = [module.lb-sg.security_group_id]
  load_balancer_type = "application"
  tags = local.common_tags

  # For example only
  enable_deletion_protection = false


  # Listener

  listeners = {
    my_lb_listener = {
      port = 80
      protocol = "HTTP"

      forward = {
        target_group_key = "my_target_group"
      }

    }
  }
  #Target groups
  target_groups = {

    my_target_group = {  # name of tg
      create_attachment = false 
      # so it wont associate an autoscaling group, since we dont have one we have to associate our instance ourselves 

      name_prefix                       = "alb-"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_algorithm_type     = "weighted_random"
      load_balancing_anomaly_mitigation = "on"
      load_balancing_cross_zone_enabled = false

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }

      protocol_version = "HTTP1"
      # target_id        = aws_instance.this.id  
      port             = 80
      tags = local.common_tags
    }

   }


}
# It is created outside the module 
resource "aws_lb_target_group_attachment" "my_target_group_attachment" {
  for_each = {
    for k, v in module.ec2_private:
      k => v
    }
  target_group_arn = module.application-lb.target_groups["my_target_group"].arn
  target_id        = each.value.id # each 
  port             = 80
}
