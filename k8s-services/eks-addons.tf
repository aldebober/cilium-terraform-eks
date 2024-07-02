locals {
  id = "test"

  project_tags = {
    "terrarom" = "true"
    "Name"     = "eks-${terraform.workspace}"
    "Env"      = "${terraform.workspace}"
  }
}

module "eks_blueprints_addons" {
  #  source = "git::https://github.com/aws-ia/terraform-aws-eks-blueprints-addon.git?ref=327207a"
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "v1.16.3"

  cluster_name      = data.terraform_remote_state.eks.outputs.cluster_name
  cluster_endpoint  = data.terraform_remote_state.eks.outputs.cluster_endpoint
  cluster_version   = data.terraform_remote_state.eks.outputs.cluster_version
  oidc_provider_arn = data.terraform_remote_state.eks.outputs.oidc_provider_arn

  eks_addons = {
    aws-ebs-csi-driver = {
      most_recent              = true
      service_account_role_arn = module.ebs_csi_driver_irsa.iam_role_arn
    }
    coredns = {
      most_recent = true

      timeouts = {
        create = "25m"
        delete = "10m"
      }
    }
  }

  enable_karpenter                    = true
  enable_metrics_server               = true
#  enable_argocd                       = true
  enable_external_dns                 = true
  enable_aws_load_balancer_controller = true
  # Becuase of Metadata v2 enabled fix alb controller deploy:
  ## args:
  ## - --aws-region=eu-central-1
  ## - --aws-vpc-id=vpc-0139ee7b318660176
  # Fix access to 9443 to webhook
  ## spec:
  ##   hostNetwork: true

  tags = local.project_tags
}

module "ebs_csi_driver_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.39"

  role_name_prefix = "${local.id}-${terraform.workspace}-ebs-csi-driver-"

  attach_ebs_csi_policy = true

  oidc_providers = {
    main = {
      provider_arn               = data.terraform_remote_state.eks.outputs.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }

  tags = local.project_tags
}

module "eks_blueprints_addon" {
  source = "aws-ia/eks-blueprints-addon/aws"
  version = "~> 1.0" #ensure to update this to the latest/desired version

  chart         = "metrics-server"
  chart_version = "3.8.2"
  repository    = "https://kubernetes-sigs.github.io/metrics-server/"
  description   = "Metric server helm Chart deployment configuration"
  namespace     = "kube-system"

  values = [
    <<-EOT
      podDisruptionBudget:
        maxUnavailable: 1
      metrics:
        enabled: true
    EOT
  ]

  set = [
    {
      name  = "replicas"
      value = 3
    }
  ]
}

module "cilium" {
  source  = "aws-ia/eks-blueprints-addon/aws"
  version = "~> 1.0" #ensure to update this to the latest/desired version

  chart            = "cilium"
  chart_version    = "1.14.2"
  repository       = "https://helm.cilium.io/"
  description      = "Cilium Networking for Kubernetes in Overlay Mode"
  namespace        = "kube-system"
  create_namespace = false

  values = [file("${path.module}/helm/cilium-values.yaml")]

  # IAM role for service account (IRSA)
  create_role = true
  role_name   = "${module.eks_vpc_us_east_1.cluster_name}-cilium-operator"

  create_policy = true
  policy_name   = "${module.eks_vpc_us_east_1.cluster_name}-cilium-operator"

  policy_statements = [
    {
      sid    = "CiliumOperator"
      effect = "Allow"
      actions = [
        "ec2:DescribeNetworkInterfaces",
        "ec2:DescribeSubnets",
        "ec2:DescribeVpcs",
        "ec2:DescribeSecurityGroups",
        "ec2:CreateNetworkInterface",
        "ec2:AttachNetworkInterface",
        "ec2:ModifyNetworkInterfaceAttribute",
        "ec2:AssignPrivateIpAddresses",
        "ec2:CreateTags",
        "ec2:UnassignPrivateIpAddresses",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeInstanceTypes"
      ]
      resources = ["*"]
    }
  ]

  oidc_providers = {
    this = {
      provider_arn = module.eks_vpc_ec1.oidc_provider_arn
      # namespace is inherited from chart
      service_account = "cilium-operator"
    }
  }

  depends_on = [
    null_resource.delete_aws_cni,
    null_resource.delete_kube_proxy
  ]
  tags = local.project_tags

}

resource "null_resource" "delete_aws_cni" {
  provisioner "local-exec" {
    command = "curl -s -k -XDELETE -H 'Authorization: Bearer ${module.eks_vpc_ec1.cluster_certificate_authority_data}' -H 'Accept: application/json' -H 'Content-Type: application/json' '${module.eks_vpc_ec1.cluster_endpoint}/apis/apps/v1/namespaces/kube-system/daemonsets/aws-node'"
  }
}

resource "null_resource" "delete_kube_proxy" {
  provisioner "local-exec" {
    command = "curl -s -k -XDELETE -H 'Authorization: Bearer ${module.eks_vpc_ec1.cluster_certificate_authority_data}' -H 'Accept: application/json' -H 'Content-Type: application/json' '${module.eks_vpc_ec1.cluster_endpoint}/apis/apps/v1/namespaces/kube-system/daemonsets/kube-proxy'"
  }
}

resource "kubernetes_config_map" "cni_config" {
  metadata {
    name      = "cni-configuration"
    namespace = "kube-system"
  }
  data = {
    "cni-config" = <<EOF
{
  "cniVersion":"1.0.0",
  "name":"cilium",
  "plugins": [
    {
      "cniVersion":"1.0.0",
      "type":"cilium-cni",
      "eni": {
        "first-interface-index": 1,
        "subnet-tags":{
          "Usage":"pods"
        }        
      }
    }
  ]
}
EOF
  }
}


