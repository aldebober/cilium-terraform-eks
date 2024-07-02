terraform {
  backend "s3" {
    bucket               = "test-terraform-states-ec1"
    key                  = "vpc.tfstate"
    workspace_key_prefix = "networking"
    region               = "eu-central-1"
  }
}
