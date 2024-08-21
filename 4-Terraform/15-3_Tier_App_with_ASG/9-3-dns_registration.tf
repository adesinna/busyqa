# DNS Registration 
resource "aws_route53_record" "apps_dns" {
  zone_id = data.aws_route53_zone.mydomain.zone_id
  name    = data.aws_route53_zone.mydomain.name # 
  type    = "A"
  alias { # route it here, A => ALB
   
    name                   = module.application-lb.dns_name #route to the lb
    zone_id                = module.application-lb.zone_id
    evaluate_target_health = true
  }  
}

# DNS Registration 
resource "aws_route53_record" "apps_dns_1" {
  zone_id = data.aws_route53_zone.mydomain.zone_id
  name    = var.app1_dns_name # for app1
  type    = "A"
  alias { # route it here, A => ALB
   
    name                   = module.application-lb.dns_name # route to the lb
    zone_id                = module.application-lb.zone_id
    evaluate_target_health = true
  }  
}

# DNS Registration 
resource "aws_route53_record" "apps_dns_2" {
  zone_id = data.aws_route53_zone.mydomain.zone_id
  name    = var.app2_dns_name   # for app2
  type    = "A"
  alias { # route it here, A => ALB
   
    name                   = module.application-lb.dns_name # route to the lb
    zone_id                = module.application-lb.zone_id
    evaluate_target_health = true
  }  
}

# # DNS Registration 
# resource "aws_route53_record" "apps_dns_3" {
#   zone_id = data.aws_route53_zone.mydomain.zone_id
#   name    = var.app3_dns_name   # for app2
#   type    = "A"
#   alias { # route it here, A => ALB
   
#     name                   = module.application-lb.dns_name # route to the lb
#     zone_id                = module.application-lb.zone_id
#     evaluate_target_health = true
#   }  
# }