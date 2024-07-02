terraform {
  backend "s3" {
    bucket               = "test-terraform-states-ec1"
    key                  = "k8s-services.tfstate"
    workspace_key_prefix = "eks-services"
    region               = "eu-central-1"
  }
}

data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "test-terraform-states-ec1"
    key    = "eks-services/${terraform.workspace}/eks.tfstate"
    region = "eu-central-1"
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

data "terraform_remote_state" "s3-logging" {
  backend = "s3"
  config = {
    bucket = "test-terraform-states-ec1"
    key    = "s3-logging.tfstate"
    region = "eu-central-1"
  }
}
