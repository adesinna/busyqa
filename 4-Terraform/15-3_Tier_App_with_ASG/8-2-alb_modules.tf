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

 # Listeners
  listeners = {
    # Listener-1: my-http-https-redirect
    my-http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }    
    }# End my-http-https-redirect Listener

    # Listener-2: my-https-listener
    my-https-listener = {
      port                        = 443
      protocol                    = "HTTPS"
      ssl_policy                  = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
      certificate_arn             = module.acm.acm_certificate_arn

       # Fixed Response for Root Context 
       fixed_response = {
        content_type = "text/plain"
        message_body = "Fixed Static message - for Root Context"
        status_code  = "200"
      }# End of Fixed Response

      # Load Balancer Rules
      rules = {
        # Rule-1: myapp1-rule
        myapp1-rule = {
          priority = 1
          actions = [{
            type = "weighted-forward"
            target_groups = [
              {
                target_group_key = "my_target_group_1"
                weight           = 1
              }
            ]
            stickiness = {
              enabled  = true
              duration = 3600
            }
          }]
          conditions = [{
            host_header = { # path/host header
              values = [var.app1_dns_name] # ["app1", "app-1", "myapp1"] If you provide it like this it would still route it to tg1
            }
          }]
        }# End of myapp1-rule


        # Rule-2: myapp2-rule
        myapp2-rule = {
          priority = 2
          actions = [{
            type = "weighted-forward"
            target_groups = [
              {
                target_group_key = "my_target_group_2"
                weight           = 1
              }
            ]
            stickiness = {
              enabled  = true
              duration = 3600
            }
          }]
          conditions = [{
            host_header = {
              values = [var.app2_dns_name] # path based ["app2", "app-2", "myapp2"] If you provide it like this it would still route it to tg2
            }
          }]
        }# End of myapp2-rule Block

        myapp3-rule = {
          priority = 3
          actions = [{
            type = "weighted-forward"
            target_groups = [
              {
                target_group_key = "my_target_group_3"
                weight           = 1
              }
            ]
            stickiness = {
              enabled  = true
              duration = 3600
            }
          }]
          conditions = [{
            path_pattern = {
              values = ["/*"] # path based ["app2", "app-2", "myapp2"] If you provide it like this it would still route it to tg2
            }
          }]
        }# End of myapp3-rule Block


      }# End Rules Block
    }# End my-https-listener Block
  }# End Listeners Blockß

  #Target groups
  target_groups = {

    my_target_group_1 = {  # name of tg
      create_attachment = false 
      # so it wont associate an autoscaling group, since we dont have one we have to associate our instance ourselves 

      name_prefix                       = "tg1-"
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
  
      tags = local.common_tags
    }

    my_target_group_2 = {  # name of tg
      create_attachment = false 
      # so it wont associate an autoscaling group, since we dont have one we have to associate our instance ourselves 

      name_prefix                       = "tg2-"
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
        path                = "/app2/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }

      protocol_version = "HTTP1"
  
      tags = local.common_tags
    }

    my_target_group_3 = {  # name of tg
      create_attachment = false 
      # so it wont associate an autoscaling group, since we dont have one we have to associate our instance ourselves 

      name_prefix                       = "tg3-"
      protocol                          = "HTTP"
      port                              = 8080
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_algorithm_type     = "weighted_random"
      load_balancing_anomaly_mitigation = "on"
      load_balancing_cross_zone_enabled = false

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/login"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }

      protocol_version = "HTTP1"
      tags = local.common_tags
    }

   }

}
