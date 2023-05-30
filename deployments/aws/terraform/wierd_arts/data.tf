data "terraform_remote_state" "core" {
  backend = "s3"

  config = {
    bucket = "dev.yashodha.space.tf.state"
    key    = "generics"
    region = "ap-south-1"
  }
}
