resource "aws_ecr_repository" "gallery_service" {
  name = "gallery-service"
}

resource "aws_ecr_repository" "gateway" {
  name = "gateway"
}

resource "aws_ecr_repository" "image_service" {
  name = "image-service"
}

resource "aws_ecr_repository" "image_processing_service" {
  name = "image-processing-service"
}
