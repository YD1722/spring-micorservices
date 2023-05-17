#module "rds-aurora_postgresql" {
#  source         = "terraform-aws-modules/rds-aurora/aws"
#  version        = "8.1.1"
#  name           = local.name
#  engine         = "aurora-postgresql"
#  engine_version = "14.5"
#  instances      = {
#    1 = {
#      instance_class = "db.t3.medium"
#    }
#  }
#
#  master_username             = "postgres"
#  manage_master_user_password = true
#
#  vpc_id               = module.vpc.vpc_id
#  db_subnet_group_name = module.vpc.database_subnet_group_name
#  security_group_rules = {
#    vpc_ingress = {
#      cidr_blocks = module.vpc.private_subnets_cidr_blocks
#    }
#  }
#
#  enabled_cloudwatch_logs_exports = ["postgresql"]
#  create_cloudwatch_log_group     = true
#
#  skip_final_snapshot = true
#
#  tags = local.tags
#}