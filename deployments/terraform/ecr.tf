module "ecr_image_service_repo" {
  source  = "terraform-aws-modules/ecr/aws//examples/complete"
  version = "1.6.0"
  repository_name = "image_service_repo"
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "ecr_gallery_service_repo" {
  source  = "terraform-aws-modules/ecr/aws//examples/complete"
  version = "1.6.0"
  repository_name = "gallery_service_repo"
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}