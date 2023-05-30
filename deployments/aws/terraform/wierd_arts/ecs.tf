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

#module "ecs_service_gateway" {
#  source = "terraform-aws-modules/ecs/aws//modules/service"
#
#  name        = local.services.gateway.name
#  cluster_arn = module.ecs_cluster.arn
#
#  cpu    = 256
#  memory = 512
#
#  create_security_group = false
#
#  container_definitions = {
#    (local.services.gallery_service.name) = {
#      #https://github.com/spring-projects/spring-boot/issues/8578
#      readonly_root_filesystem = false
#
#      cpu           = 256
#      memory        = 512
#      essential     = true
#      image         = "008744601422.dkr.ecr.ap-south-1.amazonaws.com/gateway:latest"
#      port_mappings = [
#        {
#          name          = local.services.gateway.name
#          containerPort = local.services.gateway.port
#          hostPort      = local.services.gateway.port
#        }
#      ]
#      "environment" : [
#        {
#          "name" : "ENABLE_EUREKA",
#          "value" : "false"
#        }, {
#          "name" : "OAUTH_ISSUER_URI",
#          "value" : "https://cognito-idp.ap-south-1.amazonaws.com/ap-south-1_VtTCFeOSo"
#        },
#
#      ],
#    }
#  }
#
#  load_balancer = {
#    service = {
#      target_group_arn = element(module.alb.target_group_arns, 0)
#      container_name   = local.services.gateway.name
#      container_port   = local.services.gateway.port
#    }
#  }
#
#  subnet_ids         = module.vpc.private_subnets
#  security_group_ids = [aws_security_group.allow_all.id]
#
#  tags = local.tags
#}

module "ecs_service_gallery_service" {
  source = "terraform-aws-modules/ecs/aws//modules/service"

  name        = local.services.gallery_service.name
  cluster_arn = module.ecs_cluster.arn

  cpu    = 256
  memory = 512

  create_security_group = false

  container_definitions = {
    (local.services.gallery_service.name) = {
      #https://github.com/spring-projects/spring-boot/issues/8578
      readonly_root_filesystem = false

      cpu           = 256
      memory        = 512
      essential     = true
      image         = "008744601422.dkr.ecr.ap-south-1.amazonaws.com/gallery-service:latest"
      port_mappings = [
        {
          name          = local.services.gallery_service.name
          containerPort = local.services.gallery_service.port
          hostPort      = local.services.gallery_service.port
        }
      ]
      "environment" : [
        {
          "name" : "ENABLE_EUREKA",
          "value" : "false"
        },
        {
          "name" : "DATASOURCE_URL",
          "value" : "jdbc:h2:mem:testdb"
        },
        {
          "name" : "DATASOURCE_USER",
          "value" : "sa"
        },
        {
          "name" : "DATASOURCE_PASS",
          "value" : "password"
        },
        {
          "name" : "DATASOURCE_DRIVER",
          "value" : "org.h2.Driver"
        },
        {
          "name" : "DIALECT",
          "value" : "org.hibernate.dialect.H2Dialect"
        },
        {
          "name" : "IMAGE_SERVICE_URL",
          "value" : "http://image-service:8200"
        }
      ],
    }
  }

  subnet_ids         = module.vpc.private_subnets
  security_group_ids = [aws_security_group.allow_all.id]

  tags = local.tags
}
#
#module "ecs_service_image_service" {
#  source = "terraform-aws-modules/ecs/aws//modules/service"
#
#  name        = local.services.image_service.name
#  cluster_arn = module.ecs_cluster.arn
#
#  cpu    = 256
#  memory = 512
#
#  create_security_group = false
#
#  container_definitions = {
#    (local.services.image_service.name) = {
#      #https://github.com/spring-projects/spring-boot/issues/8578
#      readonly_root_filesystem = false
#
#      cpu           = 256
#      memory        = 512
#      essential     = true
#      image         = "008744601422.dkr.ecr.ap-south-1.amazonaws.com/image-service:latest"
#      port_mappings = [
#        {
#          name          = local.services.image_service.name
#          containerPort = local.services.image_service.port
#          hostPort      = local.services.image_service.port
#        }
#      ]
#      "environment" : [
#        {
#          "name" : "ENABLE_EUREKA",
#          "value" : "false"
#        }
#      ],
#    }
#  }
#
#  subnet_ids         = module.vpc.private_subnets
#  security_group_ids = [aws_security_group.allow_all.id]
#
#  tags = local.tags
#}

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
