locals {
  region = "ap-northeast-1"
  name   = "modern-arts"

  tags = {
    ame       = local.name
    env       = "dev"
    terraform = true
  }
}