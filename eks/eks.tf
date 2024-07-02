locals {
  id = "test"

  project_tags = {
    "terrarom" = "true"
    "Name"     = "eks-${terraform.workspace}"
    "Env"      = "${terraform.workspace}"
  }
}

data "aws_caller_identity" "current" {}

module "eks_vpc_ec1" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-eks.git?ref=4c5c97b" # Version 19.21.0 (2023-12-11)

  cluster_name    = "${local.id}-${terraform.workspace}-eks"
  cluster_version = "1.29"

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = false

  vpc_id     = data.terraform_remote_state.networking.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.networking.outputs.private_subnets

  # Extend cluster security group rules
  cluster_security_group_additional_rules = {
    ingress_nodes_ephemeral_ports_tcp = {
      description                = "Nodes on ephemeral ports"
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "ingress"
      source_node_security_group = true
    }
  }

  # Extend node-to-node security group rules
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
  }

  enable_irsa = true # Enable IRSA for EKS cluster

  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler",
  ]

  eks_managed_node_group_defaults = {
    ami_type                              = "AL2_x86_64"
    capacity_type                         = "ON_DEMAND"
    attach_cluster_primary_security_group = true
    iam_role_additional_policies = {
      eks_vpc_ec1 = aws_iam_policy.eks_vpc_ec1.arn
    }
    iam_role_additional_policies = {
      eks_vpc_ec1 = aws_iam_policy.eks_vpc_ec1.arn
    }

    taints = [
      {
        key    = "node.cilium.io/agent-not-ready"
        value  = "true"
        effect = "NO_SCHEDULE"
      }
    ]
  }

  eks_managed_node_groups = {
    controllers = {
      name            = "${local.id}-${terraform.workspace}-managed"
      use_name_prefix = true
      instance_types  = ["t3.xlarge"] # Update this to your desired instance types
      capacity_type   = "ON_DEMAND"

      desired_size = var.app_min_size[terraform.workspace]
      min_size     = var.app_min_size[terraform.workspace]
      max_size     = var.app_max_size[terraform.workspace]

      ebs_optimized           = true
      disable_api_termination = false
      enable_monitoring       = true

      disk_size = 50
      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size           = 75
            volume_type           = "gp3"
            iops                  = 3000
            throughput            = 150
            encrypted             = true
            delete_on_termination = true
          }
        }
      }

      metadata_options = {
        http_endpoint               = "enabled"
        http_tokens                 = "required"
        http_put_response_hop_limit = 2
        instance_metadata_tags      = "disabled"
      }

      update_config = {
        max_unavailable_percentage = 33
      }
    }
  }

  cluster_encryption_config = {
    resources        = ["secrets"]
  }

  tags = merge(local.project_tags)
}

resource "aws_iam_policy" "eks_vpc_ec1" {
  name = module.eks_vpc_ec1.cluster_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_security_group_rule" "cluster_vpn" {
  description              = "Access to EKS API"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = data.terraform_remote_state.vpn.outputs.vpn_sg_id
  security_group_id        = module.eks_vpc_ec1.cluster_security_group_id
}
