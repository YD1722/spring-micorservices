terraform {
  backend "s3" {
    bucket = "dev.yashodha.space.tf.state"
    key    = "wierd_arts"
    region = "ap-south-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}