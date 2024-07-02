## Resources
[blueprints_adons](https://github.com/aws-ia/terraform-aws-eks-blueprints-addons/blob/main/docs/addons/karpenter.md)
[iam_roles](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/v5.39.1)
[howto1](https://dev.to/aws-builders/architecting-for-resilience-crafting-opinionated-eks-clusters-with-karpenter-cilium-cluster-mesh-part-1-1b9a)
[howto2](https://medium.com/@amitmavgupta/cilium-installing-cilium-in-eks-with-no-kube-proxy-86f54a56c360)
[prometheus](https://docs.cilium.io/en/stable/observability/grafana/)
[readme](https://github.com/littlejo/cilium-eks-cookbook?tab=readme-ov-file)


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.53.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ebs_csi_driver_irsa"></a> [ebs\_csi\_driver\_irsa](#module\_ebs\_csi\_driver\_irsa) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | ~> 5.39 |
| <a name="module_eks_blueprints_addons"></a> [eks\_blueprints\_addons](#module\_eks\_blueprints\_addons) | aws-ia/eks-blueprints-addons/aws | v1.16.3 |

## Resources

| Name | Type |
|------|------|
| [aws_eks_cluster.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [terraform_remote_state.eks](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.networking](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | `"eu-central-1"` | no |
| <a name="input_workspace_profiles"></a> [workspace\_profiles](#input\_workspace\_profiles) | AWS profile | `string` | `"test"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_karpenter_iam_role_arn"></a> [karpenter\_iam\_role\_arn](#output\_karpenter\_iam\_role\_arn) | Karpenter IAM role ARN needed to be added to aws-auth cm |
