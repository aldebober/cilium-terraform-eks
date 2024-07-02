resource "aws_s3_bucket" "loki" {
  bucket = "${data.terraform_remote_state.eks.outputs.cluster_name}-loki-chunk"

  tags = local.project_tags
}

resource "aws_s3_bucket_versioning" "loki" {
  bucket = aws_s3_bucket.loki.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_logging" "loki" {
  bucket = aws_s3_bucket.loki.id

  target_bucket = data.terraform_remote_state.s3-logging.outputs.log_bucket.id
  target_prefix = "loki-access"
}

data "aws_iam_policy_document" "loki_s3" {
  statement {
      actions = [
        "s3:ListAllMyBuckets"
      ]
      effect = "Allow"
      resources = [
	    "arn:aws:s3:::*",
	  ]
    }

  statement {
      actions = [
        "s3:ListBucket",
        "s3:GetBucketLocation"
      ]
      effect = "Allow"
      resources = [
        "arn:aws:s3:::${aws_s3_bucket.loki.bucket}",
      ]
    }

  statement {
      actions = [
        "s3:PutObject",
        "s3:PutObjectAcl",
        "s3:GetObject",
        "s3:GetObjectAcl",
        "s3:DeleteObject"
      ]
      effect = "Allow"
      resources = [
        "arn:aws:s3:::${aws_s3_bucket.loki.bucket}/*",
      ]
  }
}

resource "aws_iam_policy" "loki_policy" {
  name        = "${data.terraform_remote_state.eks.outputs.cluster_name}-loki"
  description = "Permissions that are required by Loki to manage logs."
  policy      = data.aws_iam_policy_document.loki_s3.json
}

resource "aws_iam_role" "iam_loki_role" {
  name               = "${data.terraform_remote_state.eks.outputs.cluster_name}-loki-role"
  assume_role_policy = templatefile("policies/oidc_assume_role_policy.json", { OIDC_ARN = data.terraform_remote_state.eks.outputs.oidc_provider_arn, OIDC_URL = data.terraform_remote_state.eks.outputs.oidc_provider, NAMESPACE = kubernetes_namespace.loki.id, SA_NAME = "loki" })

  tags = merge(
    {
      "ServiceAccountName"      = "loki"
      "ServiceAccountNameSpace" = kubernetes_namespace.loki.id
    }
  )
}

resource "aws_iam_role_policy_attachment" "iam_loki_policy_attachement" {
  role       = aws_iam_role.iam_loki_role.name
  policy_arn = aws_iam_policy.loki_policy.arn
}

resource "kubernetes_service_account" "loki" {
  automount_service_account_token = true
  metadata {
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.iam_loki_role.arn
    }
    labels = {
      "app.kubernetes.io/managed-by" = "terraform"
      "app.kubernetes.io/name"       = "loki"
    }
    name      = "loki"
    namespace = kubernetes_namespace.loki.id
  }
}

resource "kubernetes_namespace" "loki" {
  metadata {
    annotations = {
      name = "loki"
    }

    name = "loki"
  }
}
