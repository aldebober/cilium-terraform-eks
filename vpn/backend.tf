terraform {
  backend "s3" {
    bucket               = "test-terraform-states-ec1"
    key                  = "vpn.tfstate"
    workspace_key_prefix = "networking"
    region               = "eu-central-1"
  }
}

data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket = "test-terraform-states-ec1"
    key    = "networking/${terraform.workspace}/vpc.tfstate"
    region = "eu-central-1"
  }
}