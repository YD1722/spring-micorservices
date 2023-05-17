module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.5.0"

  name                       = "${local.name}-vpc"
  cidr                       = "10.0.0.0/16"
  azs                        = ["ap-south-1a", "ap-south-1b"]
  public_subnets             = ["10.0.101.0/24", "10.0.102.0/24"]
  private_subnets            = ["10.0.1.0/24", "10.0.2.0/24"]
  database_subnets           = ["10.0.201.0/28", "10.0.202.0/28"]
  database_subnet_group_name = "DB Subnet"
  enable_nat_gateway         = true
  single_nat_gateway         = true
  enable_dns_hostnames       = true
  enable_dns_support         = true

  tags = local.tags
}