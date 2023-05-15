
resource "aws_ecs_cluster" "wierd_arts_cluster" {
  name = "wierd_arts_cluster"
}

resource "aws_ecs_task_definition" "gallery_service_def" {
  family                   = "gallery-service-def"
  container_definitions    = file("${path.module}/task-definitions/gallery-service.json")
}

#resource "aws_ecs_task_definition" "image_service_def" {
#  family                   = "gallery-service-def"
#  container_definitions    = file("${path.module}/task-definitions/image-service.json")
#}

resource "aws_ecs_service" "gallery_service_service" {
  name            = "gallery-service"
  cluster         = aws_ecs_cluster.wierd_arts_cluster.id
  task_definition = aws_ecs_task_definition.gallery_service_def.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = module.vpc.public_subnets
    security_groups  = [aws_security_group.allow_all.id]
    assign_public_ip = true
  }
}

#resource "aws_ecs_service" "image_service_service" {
#  name            = "image-service"
#  cluster         = aws_ecs_cluster.wierd_arts_cluster.id
#  task_definition = aws_ecs_task_definition.gallery_service_def.arn
#  desired_count   = 1
#  launch_type     = "FARGATE"
#
#  network_configuration {
#    subnets          = module.vpc.public_subnets
#    security_groups  = [aws_security_group.allow_all.id]
#    assign_public_ip = true
#  }
#}

resource "aws_security_group" "allow_all" {
  name        = "wierd_arts_allow_all"
  description = "Security group for allowing all"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
