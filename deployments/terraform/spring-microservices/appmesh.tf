resource "aws_appmesh_mesh" "this" {
  name = "${local.name}-mesh"
  tags = local.tags
}

#──────▄▀▄─────▄▀▄
#─────▄█░░▀▀▀▀▀░░█▄
#─▄▄──█░░░░░░░░░░░█──▄▄
#█▄▄█─█░░▀░░┬░░▀░░█─█▄▄█
# Virtual Gateway

resource "aws_appmesh_virtual_gateway" "this" {
  name      = "${local.name}-vgw"
  mesh_name = aws_appmesh_mesh.this.name

  spec {
    listener {
      port_mapping {
        port     = 8100
        protocol = "http"
      }
    }
  }

  tags = local.tags
}

resource "aws_appmesh_gateway_route" "this" {
  name                 = "${local.name}-gwroute-gallery-service"
  mesh_name            = aws_appmesh_mesh.this.name
  virtual_gateway_name = aws_appmesh_virtual_gateway.this.name

  spec {
    http_route {
      action {
        target {
          virtual_service {
            virtual_service_name = aws_appmesh_virtual_service.gallery-service.name
          }
        }
      }

      match {
        prefix = "/"
      }
    }
  }

  tags = local.tags
}

#──────▄▀▄─────▄▀▄
#─────▄█░░▀▀▀▀▀░░█▄
#─▄▄──█░░░░░░░░░░░█──▄▄
#█▄▄█─█░░▀░░┬░░▀░░█─█▄▄█
# Virtual Service - Gallery Service

resource "aws_appmesh_virtual_service" "gallery-service" {
  name      = "gallery.art.mesh.local"
  mesh_name = aws_appmesh_mesh.this.id

  spec {
    provider {
      virtual_node {
        virtual_node_name = aws_appmesh_virtual_node.gallery-service-node.name
      }
    }
  }
}

#──────▄▀▄─────▄▀▄
#─────▄█░░▀▀▀▀▀░░█▄
#─▄▄──█░░░░░░░░░░░█──▄▄
#█▄▄█─█░░▀░░┬░░▀░░█─█▄▄█
# Virtual Node - Gallery Service
resource "aws_appmesh_virtual_node" "gallery-service-node" {
  name      = "gallery-service-1"
  mesh_name = aws_appmesh_mesh.this.id

  spec {
    listener {
      port_mapping {
        port     = 8100
        protocol = "http"
      }
    }

    service_discovery {
      dns {
        hostname = "gallery.art.mesh.local"
      }
    }
  }
}