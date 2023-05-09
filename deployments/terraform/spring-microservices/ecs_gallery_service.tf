#module "gallery-service" {
#  source       = "terraform-aws-modules/ecs/aws"
#  version      = "4.1.3"
#  cluster_name = local.name
#
#  cluster_configuration = {
#    execute_command_configuration = {
#      logging           = "OVERRIDE"
#      log_configuration = {
#        cloud_watch_log_group_name = aws_cloudwatch_log_group.this.name
#      }
#    }
#  }
#
#  fargate_capacity_providers = {
#    FARGATE = {
#      default_capacity_provider_strategy = {
#        weight = 50
#        base   = 20
#      }
#    }
#    FARGATE_SPOT = {
#      default_capacity_provider_strategy = {
#        weight = 50
#      }
#    }
#  }
#
#  tags = local.tags
#}
#
#// Cloud watch groups
#
#resource "aws_cloudwatch_log_group" "this" {
#  name              = "/aws/ecs/${local.name}"
#  retention_in_days = 7
#
#  tags = local.tags
#}
#
#// Task definitions
#
#resource "gallery_service_task_definition" "this" {
#  family                = "service"
#  container_definitions = file("task-definitions/service.json")
#
#  proxy_configuration {
#    type           = "APPMESH"
#    container_name = "applicationContainerName"
#    properties     = {
#      AppPorts         = "8080"
#      EgressIgnoredIPs = "169.254.170.2,169.254.169.254"
#      IgnoredUID       = "1337"
#      ProxyEgressPort  = 15001
#      ProxyIngressPort = 15000
#    }
#  }
#}
#
