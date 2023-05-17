module "ecs_cluster" {
  source       = "terraform-aws-modules/ecs/aws//modules/cluster"
  cluster_name = local.name

  # Capacity provider
  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 50
        base   = 20
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
  }

  tags = local.tags
}

module "ecs_service" {
  source = "terraform-aws-modules/ecs/aws//modules/service"

  name        = local.name
  cluster_arn = module.ecs_cluster.arn

  cpu    = 256
  memory = 512

  create_security_group = false

  container_definitions = {
    (local.services.gallery_service.name) = {
      cpu           = 256
      memory        = 512
      essential     = true
      image         = "008744601422.dkr.ecr.ap-south-1.amazonaws.com/gallery_service:latest"
      port_mappings = [
        {
          name          = local.services.gallery_service.name
          containerPort = local.services.gallery_service.port
          hostPort      = local.services.gallery_service.port
        }
      ]
#      "environment": [
#        {
#          "name": "DATASOURCE_URL",
#          "value": "jdbc:postgresql://${module.rds-aurora_postgresql.cluster_endpoint}"
#        }, {
#          "name": "DATASOURCE_USER",
#          "value": "postgres"
#        }, {
#          "name": "DATASOURCE_PASS",
#          "value": "${module.rds-aurora_postgresql.cluster_master_user_secret}"
#        }, {
#          "name" : "IMAGE_SERVICE_URL",
#          "value" : "http://image-service:8200"
#        }
#      ],
    }
  }

  load_balancer = {
    service = {
      target_group_arn = element(module.alb.target_group_arns, 0)
      container_name   = local.services.gallery_service.name
      container_port   = local.services.gallery_service.port
    }
  }

  subnet_ids         = module.vpc.private_subnets
  security_group_ids = [aws_security_group.allow_all.id]

  tags = local.tags
}


resource "aws_security_group" "allow_all" {
  name        = "wierd_arts_allow_all"
  description = "Security group for allowing all"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
