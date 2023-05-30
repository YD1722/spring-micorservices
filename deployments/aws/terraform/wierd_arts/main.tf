locals {
  name     = "wierd-arts"
  services = {
    gateway = {
      name : "gateway"
      port : 9080
    },
    gallery_service = {
      name : "gallery-service"
      port : 8100
    },
    image_service = {
      name : "image-service"
      port : 8200
    }
  }
  tags = {
    environment = "dev"
    terraform   = "true"
  }
}
