## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.52.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.30.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.2 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cilium"></a> [cilium](#module\_cilium) | aws-ia/eks-blueprints-addon/aws | 1.1.1 |
| <a name="module_ebs_csi_driver_irsa"></a> [ebs\_csi\_driver\_irsa](#module\_ebs\_csi\_driver\_irsa) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | ~> 5.39 |
| <a name="module_eks_blueprints_addons"></a> [eks\_blueprints\_addons](#module\_eks\_blueprints\_addons) | aws-ia/eks-blueprints-addons/aws | v1.16.3 |
| <a name="module_eks_vpc_ec1"></a> [eks\_vpc\_ec1](#module\_eks\_vpc\_ec1) | git::https://github.com/terraform-aws-modules/terraform-aws-eks.git | 4c5c97b |

[blueprints_adons](https://github.com/aws-ia/terraform-aws-eks-blueprints-addons/blob/main/docs/addons/karpenter.md)
[iam_roles](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/v5.39.1)

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.eks_vpc_ec1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_security_group_rule.cluster_vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [kubernetes_config_map.cni_config](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [null_resource.delete_aws_cni](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.delete_kube_proxy](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_eks_cluster.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [terraform_remote_state.networking](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.vpn](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_max_size"></a> [app\_max\_size](#input\_app\_max\_size) | Desired amount of node in application node group | `map` | <pre>{<br>  "dev": "5",<br>  "prod": "5"<br>}</pre> | no |
| <a name="input_app_min_size"></a> [app\_min\_size](#input\_app\_min\_size) | Minimum amount of node in application node group | `map` | <pre>{<br>  "dev": "3",<br>  "prod": "3"<br>}</pre> | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type in application node group | `map` | <pre>{<br>  "dev": "t3.2xlarge",<br>  "prod": "t3.4xlarge"<br>}</pre> | no |
| <a name="input_map_users"></a> [map\_users](#input\_map\_users) | Additional IAM users to add to the aws-auth configmap. | `map` | <pre>{<br>  "dev": []<br>}</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | `"eu-central-1"` | no |
| <a name="input_workspace_profiles"></a> [workspace\_profiles](#input\_workspace\_profiles) | AWS profile | `string` | `"txg"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_auth_configmap_yaml"></a> [aws\_auth\_configmap\_yaml](#output\_aws\_auth\_configmap\_yaml) | Formatted yaml output for base aws-auth configmap containing roles used in cluster node groups/fargate profiles |
| <a name="output_cloudwatch_log_group_arn"></a> [cloudwatch\_log\_group\_arn](#output\_cloudwatch\_log\_group\_arn) | Arn of cloudwatch log group created |
| <a name="output_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#output\_cloudwatch\_log\_group\_name) | Name of cloudwatch log group created |
| <a name="output_cluster_addons"></a> [cluster\_addons](#output\_cluster\_addons) | Map of attribute maps for all EKS cluster addons enabled |
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | The Amazon Resource Name (ARN) of the cluster |
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | Base64 encoded certificate data required to communicate with the cluster |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint for your Kubernetes API server |
| <a name="output_cluster_iam_role_arn"></a> [cluster\_iam\_role\_arn](#output\_cluster\_iam\_role\_arn) | IAM role ARN of the EKS cluster |
| <a name="output_cluster_iam_role_name"></a> [cluster\_iam\_role\_name](#output\_cluster\_iam\_role\_name) | IAM role name of the EKS cluster |
| <a name="output_cluster_iam_role_unique_id"></a> [cluster\_iam\_role\_unique\_id](#output\_cluster\_iam\_role\_unique\_id) | Stable and unique string identifying the IAM role |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The ID of the EKS cluster. Note: currently a value is returned only for local EKS clusters created on Outposts |
| <a name="output_cluster_identity_providers"></a> [cluster\_identity\_providers](#output\_cluster\_identity\_providers) | Map of attribute maps for all EKS identity providers enabled |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The name of the EKS cluster |
| <a name="output_cluster_oidc_issuer_url"></a> [cluster\_oidc\_issuer\_url](#output\_cluster\_oidc\_issuer\_url) | The URL on the EKS cluster for the OpenID Connect identity provider |
| <a name="output_cluster_platform_version"></a> [cluster\_platform\_version](#output\_cluster\_platform\_version) | Platform version for the cluster |
| <a name="output_cluster_security_group_arn"></a> [cluster\_security\_group\_arn](#output\_cluster\_security\_group\_arn) | Amazon Resource Name (ARN) of the cluster security group |
| <a name="output_cluster_security_group_id"></a> [cluster\_security\_group\_id](#output\_cluster\_security\_group\_id) | Cluster security group that was created by Amazon EKS for the cluster. Managed node groups use this security group for control-plane-to-data-plane communication. Referred to as 'Cluster security group' in the EKS console |
| <a name="output_cluster_status"></a> [cluster\_status](#output\_cluster\_status) | Status of the EKS cluster. One of `CREATING`, `ACTIVE`, `DELETING`, `FAILED` |
| <a name="output_cluster_tls_certificate_sha1_fingerprint"></a> [cluster\_tls\_certificate\_sha1\_fingerprint](#output\_cluster\_tls\_certificate\_sha1\_fingerprint) | The SHA1 fingerprint of the public key of the cluster's certificate |
| <a name="output_eks_managed_node_groups"></a> [eks\_managed\_node\_groups](#output\_eks\_managed\_node\_groups) | Map of attribute maps for all EKS managed node groups created |
| <a name="output_eks_managed_node_groups_autoscaling_group_names"></a> [eks\_managed\_node\_groups\_autoscaling\_group\_names](#output\_eks\_managed\_node\_groups\_autoscaling\_group\_names) | List of the autoscaling group names created by EKS managed node groups |
| <a name="output_fargate_profiles"></a> [fargate\_profiles](#output\_fargate\_profiles) | Map of attribute maps for all EKS Fargate Profiles created |
| <a name="output_karpenter_iam_role_arn"></a> [karpenter\_iam\_role\_arn](#output\_karpenter\_iam\_role\_arn) | Karpenter IAM role ARN needed to be added to aws-auth cm |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | The Amazon Resource Name (ARN) of the key |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | The globally unique identifier for the key |
| <a name="output_kms_key_policy"></a> [kms\_key\_policy](#output\_kms\_key\_policy) | The IAM resource policy set on the key |
| <a name="output_oidc_provider"></a> [oidc\_provider](#output\_oidc\_provider) | The OpenID Connect identity provider (issuer URL without leading `https://`) |
| <a name="output_oidc_provider_arn"></a> [oidc\_provider\_arn](#output\_oidc\_provider\_arn) | The ARN of the OIDC Provider if `enable_irsa = true` |
| <a name="output_self_managed_node_groups"></a> [self\_managed\_node\_groups](#output\_self\_managed\_node\_groups) | Map of attribute maps for all self managed node groups created |
| <a name="output_self_managed_node_groups_autoscaling_group_names"></a> [self\_managed\_node\_groups\_autoscaling\_group\_names](#output\_self\_managed\_node\_groups\_autoscaling\_group\_names) | List of the autoscaling group names created by self-managed node groups |


       _               _              
   ___| |__   ___  ___| | _______   __
  / __| '_ \ / _ \/ __| |/ / _ \ \ / /
 | (__| | | |  __/ (__|   < (_) \ V / 
  \___|_| |_|\___|\___|_|\_\___/ \_/  
                                      
By Prisma Cloud | version: 3.2.80 
Update available 3.2.80 -> 3.2.120
Run pip3 install -U checkov to update 


terraform scan results:

Passed checks: 15, Failed checks: 4, Skipped checks: 0

```
Check: CKV_K8S_21: "The default namespace should not be used"
	PASSED for resource: kubernetes_config_map.cni_config
	File: /eks-addons.tf:56-81
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/kubernetes-policies/kubernetes-policy-index/bc-k8s-20
Check: CKV_AWS_288: "Ensure IAM policies does not allow data exfiltration"
	PASSED for resource: aws_iam_policy.eks_vpc_ec1
	File: /eks.tf:124-139
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/bc-aws-288
Check: CKV_AWS_290: "Ensure IAM policies does not allow write access without constraints"
	PASSED for resource: aws_iam_policy.eks_vpc_ec1
	File: /eks.tf:124-139
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/bc-aws-290
Check: CKV_AWS_287: "Ensure IAM policies does not allow credentials exposure"
	PASSED for resource: aws_iam_policy.eks_vpc_ec1
	File: /eks.tf:124-139
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/bc-aws-287
Check: CKV_AWS_63: "Ensure no IAM policies documents allow "*" as a statement's actions"
	PASSED for resource: aws_iam_policy.eks_vpc_ec1
	File: /eks.tf:124-139
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/iam-48
Check: CKV_AWS_289: "Ensure IAM policies does not allow permissions management / resource exposure without constraints"
	PASSED for resource: aws_iam_policy.eks_vpc_ec1
	File: /eks.tf:124-139
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/bc-aws-289
Check: CKV_AWS_62: "Ensure IAM policies that allow full "*-*" administrative privileges are not created"
	PASSED for resource: aws_iam_policy.eks_vpc_ec1
	File: /eks.tf:124-139
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/bc-aws-iam-45
Check: CKV_AWS_286: "Ensure IAM policies does not allow privilege escalation"
	PASSED for resource: aws_iam_policy.eks_vpc_ec1
	File: /eks.tf:124-139
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/bc-aws-286
Check: CKV_AWS_260: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 80"
	PASSED for resource: aws_security_group_rule.cluster_vpn
	File: /eks.tf:141-149
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-security-groups-do-not-allow-ingress-from-00000-to-port-80
Check: CKV_AWS_24: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 22"
	PASSED for resource: aws_security_group_rule.cluster_vpn
	File: /eks.tf:141-149
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-1-port-security
Check: CKV_AWS_23: "Ensure every security group and rule has a description"
	PASSED for resource: aws_security_group_rule.cluster_vpn
	File: /eks.tf:141-149
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-31
Check: CKV_AWS_277: "Ensure no security groups allow ingress from 0.0.0.0:0 to port -1"
	PASSED for resource: aws_security_group_rule.cluster_vpn
	File: /eks.tf:141-149
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-security-group-does-not-allow-all-traffic-on-all-ports
Check: CKV_AWS_25: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 3389"
	PASSED for resource: aws_security_group_rule.cluster_vpn
	File: /eks.tf:141-149
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-2
Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
	PASSED for resource: eks_vpc_ec1
	File: /eks.tf:11-122
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/supply-chain-policies/terraform-policies/ensure-terraform-module-sources-use-git-url-with-commit-hash-revision
Check: CKV_AWS_41: "Ensure no hard coded AWS access key and secret key exists in provider"
	PASSED for resource: aws.default
	File: /main.tf:5-8
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/secrets-policies/bc-aws-secrets-5
Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
	FAILED for resource: eks_blueprints_addons
	File: /eks-addons.tf:13-54
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/supply-chain-policies/terraform-policies/ensure-terraform-module-sources-use-git-url-with-commit-hash-revision

		13 | module "eks_blueprints_addons" {
		14 |   #  source = "git::https://github.com/aws-ia/terraform-aws-eks-blueprints-addon.git?ref=327207a"
		15 |   source  = "aws-ia/eks-blueprints-addons/aws"
		16 |   version = "v1.16.3"
		17 | 
		18 |   cluster_name      = module.eks_vpc_ec1.cluster_name
		19 |   cluster_endpoint  = module.eks_vpc_ec1.cluster_endpoint
		20 |   cluster_version   = module.eks_vpc_ec1.cluster_version
		21 |   oidc_provider_arn = module.eks_vpc_ec1.oidc_provider_arn
		22 | 
		23 | 
		24 |   eks_addons = {
		25 |     aws-ebs-csi-driver = {
		26 |       most_recent              = true
		27 |       service_account_role_arn = module.ebs_csi_driver_irsa.iam_role_arn
		28 |     }
		29 |     coredns = {
		30 |       most_recent = true
		31 | 
		32 |       timeouts = {
		33 |         create = "25m"
		34 |         delete = "10m"
		35 |       }
		36 |     }
		37 |   }
		38 | 
		39 |   # For using spot instances with karpenter check linked role in account
		40 |   ## aws iam create-service-linked-role --aws-service-name spot.amazonaws.com || true
		41 |   # After deploying Karpenter Chart add its iam role arn from output to aws-auth cm:
		42 |   #     - "groups":
		43 |   #       - "system:bootstrappers"
		44 |   #       - "system:nodes"
		45 |   #       "rolearn": module.eks_blueprints_addons.karpenter.node_iam_role_arn
		46 |   #       "username": "system:node:{{EC2PrivateDNSName}}"
		47 | 
		48 |   enable_karpenter      = true
		49 |   enable_argocd         = true
		50 |   enable_metrics_server = true
		51 |   enable_external_dns   = true
		52 | 
		53 |   tags = local.project_tags
		54 | }

Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
	FAILED for resource: ebs_csi_driver_irsa
	File: /eks-addons.tf:83-99
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/supply-chain-policies/terraform-policies/ensure-terraform-module-sources-use-git-url-with-commit-hash-revision

		83 | module "ebs_csi_driver_irsa" {
		84 |   source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
		85 |   version = "~> 5.39"
		86 | 
		87 |   role_name_prefix = "${local.id}-${terraform.workspace}-ebs-csi-driver-"
		88 | 
		89 |   attach_ebs_csi_policy = true
		90 | 
		91 |   oidc_providers = {
		92 |     main = {
		93 |       provider_arn               = module.eks_vpc_ec1.oidc_provider_arn
		94 |       namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
		95 |     }
		96 |   }
		97 | 
		98 |   tags = local.project_tags
		99 | }

Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
	FAILED for resource: cilium
	File: /eks-addons.tf:101-153
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/supply-chain-policies/terraform-policies/ensure-terraform-module-sources-use-git-url-with-commit-hash-revision

		Code lines for this resource are too many. Please use IDE of your choice to review the file.
Check: CKV_AWS_355: "Ensure no IAM policies documents allow "*" as a statement's resource for restrictable actions"
	FAILED for resource: aws_iam_policy.eks_vpc_ec1
	File: /eks.tf:124-139
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/bc-aws-355

		124 | resource "aws_iam_policy" "eks_vpc_ec1" {
		125 |   name = module.eks_vpc_ec1.cluster_name
		126 | 
		127 |   policy = jsonencode({
		128 |     Version = "2012-10-17"
		129 |     Statement = [
		130 |       {
		131 |         Action = [
		132 |           "ec2:Describe*",
		133 |         ]
		134 |         Effect   = "Allow"
		135 |         Resource = "*"
		136 |       },
		137 |     ]
		138 |   })
		139 | }
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks_vpc_ec1"></a> [eks\_vpc\_ec1](#module\_eks\_vpc\_ec1) | git::https://github.com/terraform-aws-modules/terraform-aws-eks.git | 4c5c97b |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.eks_vpc_ec1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_security_group.allow_alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.alb_to_eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cluster_vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [terraform_remote_state.networking](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.vpn](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_max_size"></a> [app\_max\_size](#input\_app\_max\_size) | Desired amount of node in application node group | `map` | <pre>{<br>  "dev": "5",<br>  "prod": "5"<br>}</pre> | no |
| <a name="input_app_min_size"></a> [app\_min\_size](#input\_app\_min\_size) | Minimum amount of node in application node group | `map` | <pre>{<br>  "dev": "3",<br>  "prod": "3"<br>}</pre> | no |
| <a name="input_clowdflare_ipv4"></a> [clowdflare\_ipv4](#input\_clowdflare\_ipv4) | List of Clowdflare ipv4 addresses | `list` | <pre>[<br>  "173.245.48.0/20",<br>  "103.21.244.0/22",<br>  "103.22.200.0/22",<br>  "103.31.4.0/22",<br>  "141.101.64.0/18",<br>  "108.162.192.0/18",<br>  "190.93.240.0/20",<br>  "188.114.96.0/20",<br>  "197.234.240.0/22",<br>  "198.41.128.0/17",<br>  "162.158.0.0/15",<br>  "104.16.0.0/12",<br>  "172.64.0.0/13",<br>  "131.0.72.0/22",<br>  "52.59.73.87/32",<br>  "35.157.14.176/32",<br>  "52.29.7.216/32",<br>  "52.29.248.104/32",<br>  "52.28.129.38/32",<br>  "35.158.45.172/32",<br>  "104.16.0.0/13",<br>  "104.24.0.0/14"<br>]</pre> | no |
| <a name="input_create_kms_key"></a> [create\_kms\_key](#input\_create\_kms\_key) | Instance type in application node group | `map` | <pre>{<br>  "dev": "false",<br>  "prod": "true"<br>}</pre> | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type in application node group | `map` | <pre>{<br>  "dev": "t3.2xlarge",<br>  "prod": "t3.4xlarge"<br>}</pre> | no |
| <a name="input_office_ipv4"></a> [office\_ipv4](#input\_office\_ipv4) | List of Clowdflare ipv4 addresses | `list` | <pre>[<br>  "35.159.151.129/32"<br>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | `"eu-central-1"` | no |
| <a name="input_workspace_profiles"></a> [workspace\_profiles](#input\_workspace\_profiles) | AWS profile | `string` | `"test"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_security_group_id"></a> [alb\_security\_group\_id](#output\_alb\_security\_group\_id) | Security group ID for ALB ingress |
| <a name="output_aws_auth_configmap_yaml"></a> [aws\_auth\_configmap\_yaml](#output\_aws\_auth\_configmap\_yaml) | Formatted yaml output for base aws-auth configmap containing roles used in cluster node groups/fargate profiles |
| <a name="output_cloudwatch_log_group_arn"></a> [cloudwatch\_log\_group\_arn](#output\_cloudwatch\_log\_group\_arn) | Arn of cloudwatch log group created |
| <a name="output_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#output\_cloudwatch\_log\_group\_name) | Name of cloudwatch log group created |
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | The Amazon Resource Name (ARN) of the cluster |
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | Base64 encoded certificate data required to communicate with the cluster |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint for your Kubernetes API server |
| <a name="output_cluster_iam_role_arn"></a> [cluster\_iam\_role\_arn](#output\_cluster\_iam\_role\_arn) | IAM role ARN of the EKS cluster |
| <a name="output_cluster_iam_role_name"></a> [cluster\_iam\_role\_name](#output\_cluster\_iam\_role\_name) | IAM role name of the EKS cluster |
| <a name="output_cluster_iam_role_unique_id"></a> [cluster\_iam\_role\_unique\_id](#output\_cluster\_iam\_role\_unique\_id) | Stable and unique string identifying the IAM role |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The ID of the EKS cluster. Note: currently a value is returned only for local EKS clusters created on Outposts |
| <a name="output_cluster_identity_providers"></a> [cluster\_identity\_providers](#output\_cluster\_identity\_providers) | Map of attribute maps for all EKS identity providers enabled |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The name of the EKS cluster |
| <a name="output_cluster_oidc_issuer_url"></a> [cluster\_oidc\_issuer\_url](#output\_cluster\_oidc\_issuer\_url) | The URL on the EKS cluster for the OpenID Connect identity provider |
| <a name="output_cluster_platform_version"></a> [cluster\_platform\_version](#output\_cluster\_platform\_version) | Platform version for the cluster |
| <a name="output_cluster_security_group_arn"></a> [cluster\_security\_group\_arn](#output\_cluster\_security\_group\_arn) | Amazon Resource Name (ARN) of the cluster security group |
| <a name="output_cluster_security_group_id"></a> [cluster\_security\_group\_id](#output\_cluster\_security\_group\_id) | Cluster security group that was created by Amazon EKS for the cluster. Managed node groups use this security group for control-plane-to-data-plane communication. Referred to as 'Cluster security group' in the EKS console |
| <a name="output_cluster_status"></a> [cluster\_status](#output\_cluster\_status) | Status of the EKS cluster. One of `CREATING`, `ACTIVE`, `DELETING`, `FAILED` |
| <a name="output_cluster_tls_certificate_sha1_fingerprint"></a> [cluster\_tls\_certificate\_sha1\_fingerprint](#output\_cluster\_tls\_certificate\_sha1\_fingerprint) | The SHA1 fingerprint of the public key of the cluster's certificate |
| <a name="output_cluster_version"></a> [cluster\_version](#output\_cluster\_version) | The Amazon Resource Name (ARN) of the cluster |
| <a name="output_eks_managed_node_groups"></a> [eks\_managed\_node\_groups](#output\_eks\_managed\_node\_groups) | Map of attribute maps for all EKS managed node groups created |
| <a name="output_eks_managed_node_groups_autoscaling_group_names"></a> [eks\_managed\_node\_groups\_autoscaling\_group\_names](#output\_eks\_managed\_node\_groups\_autoscaling\_group\_names) | List of the autoscaling group names created by EKS managed node groups |
| <a name="output_fargate_profiles"></a> [fargate\_profiles](#output\_fargate\_profiles) | Map of attribute maps for all EKS Fargate Profiles created |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | The Amazon Resource Name (ARN) of the key |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | The globally unique identifier for the key |
| <a name="output_kms_key_policy"></a> [kms\_key\_policy](#output\_kms\_key\_policy) | The IAM resource policy set on the key |
| <a name="output_node_security_group_id"></a> [node\_security\_group\_id](#output\_node\_security\_group\_id) | Amazon Resource Name (ARN) of the cluster security group |
| <a name="output_oidc_provider"></a> [oidc\_provider](#output\_oidc\_provider) | The OpenID Connect identity provider (issuer URL without leading `https://`) |
| <a name="output_oidc_provider_arn"></a> [oidc\_provider\_arn](#output\_oidc\_provider\_arn) | The ARN of the OIDC Provider if `enable_irsa = true` |
| <a name="output_self_managed_node_groups"></a> [self\_managed\_node\_groups](#output\_self\_managed\_node\_groups) | Map of attribute maps for all self managed node groups created |
| <a name="output_self_managed_node_groups_autoscaling_group_names"></a> [self\_managed\_node\_groups\_autoscaling\_group\_names](#output\_self\_managed\_node\_groups\_autoscaling\_group\_names) | List of the autoscaling group names created by self-managed node groups |
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks_vpc_ec1"></a> [eks\_vpc\_ec1](#module\_eks\_vpc\_ec1) | git::https://github.com/terraform-aws-modules/terraform-aws-eks.git | 4c5c97b |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.eks_vpc_ec1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_security_group.allow_alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.alb_to_eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cluster_vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [terraform_remote_state.networking](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.vpn](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_max_size"></a> [app\_max\_size](#input\_app\_max\_size) | Desired amount of node in application node group | `map` | <pre>{<br>  "dev": "5",<br>  "prod": "5"<br>}</pre> | no |
| <a name="input_app_min_size"></a> [app\_min\_size](#input\_app\_min\_size) | Minimum amount of node in application node group | `map` | <pre>{<br>  "dev": "3",<br>  "prod": "3"<br>}</pre> | no |
| <a name="input_clowdflare_ipv4"></a> [clowdflare\_ipv4](#input\_clowdflare\_ipv4) | List of Clowdflare ipv4 addresses | `list` | <pre>[<br>  "173.245.48.0/20",<br>  "103.21.244.0/22",<br>  "103.22.200.0/22",<br>  "103.31.4.0/22",<br>  "141.101.64.0/18",<br>  "108.162.192.0/18",<br>  "190.93.240.0/20",<br>  "188.114.96.0/20",<br>  "197.234.240.0/22",<br>  "198.41.128.0/17",<br>  "162.158.0.0/15",<br>  "104.16.0.0/12",<br>  "172.64.0.0/13",<br>  "131.0.72.0/22",<br>  "52.59.73.87/32",<br>  "35.157.14.176/32",<br>  "52.29.7.216/32",<br>  "52.29.248.104/32",<br>  "52.28.129.38/32",<br>  "35.158.45.172/32",<br>  "104.16.0.0/13",<br>  "104.24.0.0/14"<br>]</pre> | no |
| <a name="input_create_kms_key"></a> [create\_kms\_key](#input\_create\_kms\_key) | Instance type in application node group | `map` | <pre>{<br>  "dev": "false",<br>  "prod": "true"<br>}</pre> | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type in application node group | `map` | <pre>{<br>  "dev": "t3.2xlarge",<br>  "prod": "t3.4xlarge"<br>}</pre> | no |
| <a name="input_office_ipv4"></a> [office\_ipv4](#input\_office\_ipv4) | List of Clowdflare ipv4 addresses | `list` | <pre>[<br>  "35.159.151.129/32"<br>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | `"eu-central-1"` | no |
| <a name="input_workspace_profiles"></a> [workspace\_profiles](#input\_workspace\_profiles) | AWS profile | `string` | `"test"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_security_group_id"></a> [alb\_security\_group\_id](#output\_alb\_security\_group\_id) | Security group ID for ALB ingress |
| <a name="output_aws_auth_configmap_yaml"></a> [aws\_auth\_configmap\_yaml](#output\_aws\_auth\_configmap\_yaml) | Formatted yaml output for base aws-auth configmap containing roles used in cluster node groups/fargate profiles |
| <a name="output_cloudwatch_log_group_arn"></a> [cloudwatch\_log\_group\_arn](#output\_cloudwatch\_log\_group\_arn) | Arn of cloudwatch log group created |
| <a name="output_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#output\_cloudwatch\_log\_group\_name) | Name of cloudwatch log group created |
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | The Amazon Resource Name (ARN) of the cluster |
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | Base64 encoded certificate data required to communicate with the cluster |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint for your Kubernetes API server |
| <a name="output_cluster_iam_role_arn"></a> [cluster\_iam\_role\_arn](#output\_cluster\_iam\_role\_arn) | IAM role ARN of the EKS cluster |
| <a name="output_cluster_iam_role_name"></a> [cluster\_iam\_role\_name](#output\_cluster\_iam\_role\_name) | IAM role name of the EKS cluster |
| <a name="output_cluster_iam_role_unique_id"></a> [cluster\_iam\_role\_unique\_id](#output\_cluster\_iam\_role\_unique\_id) | Stable and unique string identifying the IAM role |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The ID of the EKS cluster. Note: currently a value is returned only for local EKS clusters created on Outposts |
| <a name="output_cluster_identity_providers"></a> [cluster\_identity\_providers](#output\_cluster\_identity\_providers) | Map of attribute maps for all EKS identity providers enabled |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The name of the EKS cluster |
| <a name="output_cluster_oidc_issuer_url"></a> [cluster\_oidc\_issuer\_url](#output\_cluster\_oidc\_issuer\_url) | The URL on the EKS cluster for the OpenID Connect identity provider |
| <a name="output_cluster_platform_version"></a> [cluster\_platform\_version](#output\_cluster\_platform\_version) | Platform version for the cluster |
| <a name="output_cluster_security_group_arn"></a> [cluster\_security\_group\_arn](#output\_cluster\_security\_group\_arn) | Amazon Resource Name (ARN) of the cluster security group |
| <a name="output_cluster_security_group_id"></a> [cluster\_security\_group\_id](#output\_cluster\_security\_group\_id) | Cluster security group that was created by Amazon EKS for the cluster. Managed node groups use this security group for control-plane-to-data-plane communication. Referred to as 'Cluster security group' in the EKS console |
| <a name="output_cluster_status"></a> [cluster\_status](#output\_cluster\_status) | Status of the EKS cluster. One of `CREATING`, `ACTIVE`, `DELETING`, `FAILED` |
| <a name="output_cluster_tls_certificate_sha1_fingerprint"></a> [cluster\_tls\_certificate\_sha1\_fingerprint](#output\_cluster\_tls\_certificate\_sha1\_fingerprint) | The SHA1 fingerprint of the public key of the cluster's certificate |
| <a name="output_cluster_version"></a> [cluster\_version](#output\_cluster\_version) | The Amazon Resource Name (ARN) of the cluster |
| <a name="output_eks_managed_node_groups"></a> [eks\_managed\_node\_groups](#output\_eks\_managed\_node\_groups) | Map of attribute maps for all EKS managed node groups created |
| <a name="output_eks_managed_node_groups_autoscaling_group_names"></a> [eks\_managed\_node\_groups\_autoscaling\_group\_names](#output\_eks\_managed\_node\_groups\_autoscaling\_group\_names) | List of the autoscaling group names created by EKS managed node groups |
| <a name="output_fargate_profiles"></a> [fargate\_profiles](#output\_fargate\_profiles) | Map of attribute maps for all EKS Fargate Profiles created |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | The Amazon Resource Name (ARN) of the key |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | The globally unique identifier for the key |
| <a name="output_kms_key_policy"></a> [kms\_key\_policy](#output\_kms\_key\_policy) | The IAM resource policy set on the key |
| <a name="output_node_security_group_id"></a> [node\_security\_group\_id](#output\_node\_security\_group\_id) | Amazon Resource Name (ARN) of the cluster security group |
| <a name="output_oidc_provider"></a> [oidc\_provider](#output\_oidc\_provider) | The OpenID Connect identity provider (issuer URL without leading `https://`) |
| <a name="output_oidc_provider_arn"></a> [oidc\_provider\_arn](#output\_oidc\_provider\_arn) | The ARN of the OIDC Provider if `enable_irsa = true` |
| <a name="output_self_managed_node_groups"></a> [self\_managed\_node\_groups](#output\_self\_managed\_node\_groups) | Map of attribute maps for all self managed node groups created |
| <a name="output_self_managed_node_groups_autoscaling_group_names"></a> [self\_managed\_node\_groups\_autoscaling\_group\_names](#output\_self\_managed\_node\_groups\_autoscaling\_group\_names) | List of the autoscaling group names created by self-managed node groups |
