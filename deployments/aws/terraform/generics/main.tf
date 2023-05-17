resource "aws_ecr_repository" "gallery_service" {
  name = "gallery_service"
}

resource "aws_ecr_repository" "image_service" {
  name = "image_service"
}

resource "aws_ecr_repository" "image_processing_service" {
  name = "image_processing_service"
}
