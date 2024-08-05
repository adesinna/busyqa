module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.4.0"

  # VPC Basic Details
  name = "${local.name}-${var.vpc_name}"
  cidr = var.vpc_cidr_block
  azs  = var.vpc_availability_zones
  public_subnets  = var.vpc_public_subnets

  # Comment out or remove private subnet configurations
  # private_subnets = var.vpc_private_subnets

  # Comment out or remove database subnet configurations
  # database_subnets = var.vpc_database_subnets
  # create_database_subnet_group = var.vpc_create_database_subnet_group
  # create_database_subnet_route_table = var.vpc_create_database_subnet_route_table

  # Disable NAT Gateway since we don't need private subnets
  enable_nat_gateway = false
  # single_nat_gateway = var.vpc_single_nat_gateway

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags     = local.common_tags
  vpc_tags = local.common_tags

  # Additional Tags to Subnets
  public_subnet_tags = {
    Type = "Public Subnets"
  }

  # Comment out or remove private subnet tags
  # private_subnet_tags = {
  #   Type = "Private Subnets"
  # }
  # database_subnet_tags = {
  #   Type = "Private Database Subnets"
  # }
}
