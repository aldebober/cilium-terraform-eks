################################################################################
# EKS Addons
################################################################################
output "karpenter_iam_role_arn" {
  description = "Karpenter IAM role ARN needed to be added to aws-auth cm"
  value       = module.eks_blueprints_addons.karpenter.node_iam_role_arn
}

