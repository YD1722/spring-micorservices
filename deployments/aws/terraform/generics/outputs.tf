output "gateway_repo" {
  value = aws_ecr_repository.gateway.repository_url
}

output "gallery_service_repo" {
  value = aws_ecr_repository.gallery_service.repository_url
}

output "image_service_repo" {
  value = aws_ecr_repository.image_service.repository_url
}

output "image_processing_service_repo" {
  value = aws_ecr_repository.image_processing_service.repository_url
}