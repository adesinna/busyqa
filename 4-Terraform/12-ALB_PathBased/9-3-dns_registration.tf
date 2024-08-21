# DNS Registration 
resource "aws_route53_record" "apps_dns" {
  zone_id = data.aws_route53_zone.mydomain.zone_id
  name    = data.aws_route53_zone.mydomain.name
  type    = "A"
  alias { # route it here, A => ALB
   
    name                   = module.application-lb.dns_name
    zone_id                = module.application-lb.zone_id
    evaluate_target_health = true
  }  
}