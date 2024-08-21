module "aws-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"



  # the basic details
  name = "aws-vpc"
  cidr = "10.0.0.0/16"


  azs = ["us-west-1a", "us-west-1b"]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
  database_subnets = ["10.0.5.0/24", "10.0.6.0/24"]

  private_subnet_names = ["priv-sub-1", "priv-sub-2"]
  public_subnet_names = ["pub-sub-1", "pub-sub-2"]
  database_subnet_names = ["db-sub-1", "db-sub-2"]


  create_database_subnet_group  = true
   # NAT Gateways - Outbound Communication
  enable_nat_gateway = true
  single_nat_gateway = true
  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support = true

  public_subnet_tags = {
    type = "public subnet"
  }

  private_subnet_tags = {
    type = "private subnet"
  }

  database_subnet_tags = {
    type = "db subnet"
  }
}


