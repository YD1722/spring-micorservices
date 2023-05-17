locals {
  name     = "wierd-arts"
  services = {
    gallery_service = {
      name : "gallery-service"
      port : 8100
    },
    image_service = {
      name : "gallery-service"
      port : 8200
    }
  }
  tags = {
    environment = "dev"
    terraform   = "true"
  }
}
