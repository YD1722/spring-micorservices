resource "aws_service_discovery_private_dns_namespace" "this" {
  name        = "art.mesh.local"
  description = "art.mesh.local"
  vpc         = module.vpc.vpc_id
}

resource "aws_service_discovery_service" "gallery-service" {
  name = "${local.name}-gallery-service"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.this.id

    dns_records {
      ttl  = 5
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

resource "aws_service_discovery_service" "gateway" {
  name = "${local.name}-gateway"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.this.id

    dns_records {
      ttl  = 5
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}