terraform {
  backend "s3" {
    bucket = "dev.yashodha.space.tf.state"
    key    = "generics"
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