data "aws_iam_policy_document" "argocd_image_updater_policy" {
  statement {
      actions = [
        "ecr:ListTagsForResource",
        "ecr:ListImages",
        "ecr:GetRepositoryPolicy",
        "ecr:GetLifecyclePolicyPreview",
        "ecr:GetLifecyclePolicy",
        "ecr:GetDownloadUrlForLayer",
        "ecr:GetAuthorizationToken",
        "ecr:DescribeRepositories",
        "ecr:DescribeImages",
        "ecr:DescribeImageScanFindings",
        "ecr:BatchGetImage",
        "ecr:BatchCheckLayerAvailability"
      ]
      effect = "Allow"
      resources = [
	    "*",
	  ]
    }
}

resource "aws_iam_policy" "updater_policy" {
  name        = "${data.terraform_remote_state.eks.outputs.cluster_name}-image-updater"
  description = "Permissions that are required by ArgoCD Image Updater to search images."
  policy      = data.aws_iam_policy_document.argocd_image_updater_policy.json
}

resource "aws_iam_role" "iam_updater_role" {
  name               = "${data.terraform_remote_state.eks.outputs.cluster_name}-updater-role"
  assume_role_policy = templatefile("policies/oidc_assume_role_policy.json", { 
    OIDC_ARN = data.terraform_remote_state.eks.outputs.oidc_provider_arn,
    OIDC_URL = data.terraform_remote_state.eks.outputs.oidc_provider,
    NAMESPACE = "argocd",
    SA_NAME = "updater" 
  })

  tags = merge(
    {
      "ServiceAccountName"      = "updater"
      "ServiceAccountNameSpace" = "argocd"
    }
  )
}

resource "aws_iam_role_policy_attachment" "iam_updater_policy_attachement" {
  role       = aws_iam_role.iam_updater_role.name
  policy_arn = aws_iam_policy.updater_policy.arn
}

resource "kubernetes_service_account" "updater" {
  automount_service_account_token = true
  metadata {
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.iam_updater_role.arn
    }
    labels = {
      "app.kubernetes.io/managed-by" = "terraform"
      "app.kubernetes.io/name"       = "updater"
    }
    name      = "updater"
    namespace = "argocd"
  }
}

