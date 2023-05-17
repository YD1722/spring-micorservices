resource "aws_s3_bucket" "alb_access_logs" {
  bucket = "${local.name}-alb-access-logs"
  tags   = local.tags
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = local.name

  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
  security_groups = [aws_security_group.allow_all.id]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    },
  ]

  target_groups = [
    {
      name             = "${local.name}-${local.services.gallery_service.name}"
      backend_protocol = "HTTP"
      backend_port     = local.services.gallery_service.port
      target_type      = "ip"
    },
  ]
}