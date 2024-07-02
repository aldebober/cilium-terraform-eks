terraform {
  required_version = ">= 1.8.0"

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.workspace_profiles
}

#data "aws_eks_cluster" "eks" {
#  name = module.eks_vpc_ec1.cluster_name
#}

#data "aws_eks_cluster_auth" "eks" {
#  name = module.eks_vpc_ec1.cluster_name
#}

#provider "kubernetes" {
#  host                   = data.aws_eks_cluster.eks.endpoint
#  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
#  token                  = data.aws_eks_cluster_auth.eks.token
#}
#
#provider "helm" {
#  kubernetes {
#    host                   = data.aws_eks_cluster.eks.endpoint
#    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
#
#    exec {
#      api_version = "client.authentication.k8s.io/v1beta1"
#      command     = "aws"
#      # This requires the awscli to be installed locally where Terraform is executed
#      args = ["eks", "get-token", "--cluster-name", module.eks_vpc_ec1.cluster_name]
#    }
#  }
#}

