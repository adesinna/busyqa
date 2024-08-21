module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "5.0.1"

  domain_name = trimsuffix(data.aws_route53_zone.mydomain.name, ".") #Incase the ...com. 
  zone_id = data.aws_route53_zone.mydomain.zone_id 
  wait_for_validation = true # should be true but w
  validation_method = "DNS"
  tags = local.common_tags

  subject_alternative_names = [
    "*.shananatestingdevops.xyz"
  ]

    
}

# Output ACM Certificate ARN
output "acm_certificate_arn" {
  description = "The ARN of the certificate"
  value       = module.acm.acm_certificate_arn
}