module "ecr_image_service_repo" {
  source          = "../modules/ecr"
  repository_name = "image_service_repo"
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "ecr_gallery_service_repo" {
  source          = "../modules/ecr"
  repository_name = "gallery_service_repo"
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}