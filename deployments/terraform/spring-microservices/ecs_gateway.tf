#resource "aws_ecs_task_definition" "service" {
#  family                = "${local.name}-gateway"
#  container_definitions = jsonencode([
#    {
#      name         = "envoy"
#      image        = "840364872350.dkr.ecr.ap-northeast-1.amazonaws.com/aws-appmesh-envoy:v1.25.1.0-prod"
#      cpu          = 0
#      memory       = 512
#      essential    = true
#      portMappings = [
#        {
#          containerPort = 8100
#          hostPort      = 8100
#        }
#      ]
#      environment = [
#        {
#          "name" : "APPMESH_RESOURCE_ARN",
#          "value" : "mesh/${aws_appmesh_mesh.this.name}/virtualGateway/$"
#        }
#      ]
#    },
#  ])
#
#  volume {
#    name      = "service-storage"
#    host_path = "/ecs/service-storage"
#  }
#
#  placement_constraints {
#    type       = "memberOf"
#    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
#  }
#}
#
