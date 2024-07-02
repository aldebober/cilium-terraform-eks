resource "aws_s3_bucket" "backup" {
  bucket = "${data.terraform_remote_state.eks.outputs.cluster_name}-backup"

  tags = local.project_tags
}

resource "aws_s3_bucket_versioning" "backup" {
  bucket = aws_s3_bucket.backup.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_logging" "backup" {
  bucket = aws_s3_bucket.backup.id

  target_bucket = data.terraform_remote_state.s3-logging.outputs.log_bucket.id
  target_prefix = "cnpg-access"
}

data "aws_iam_policy_document" "backup_s3" {
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
        "arn:aws:s3:::${aws_s3_bucket.backup.bucket}",
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
        "arn:aws:s3:::${aws_s3_bucket.backup.bucket}/*",
      ]
  }
}

resource "aws_iam_policy" "backup_policy" {
  name        = "${data.terraform_remote_state.eks.outputs.cluster_name}-backup"
  description = "Permissions that are required by sa to backup to S3."
  policy      = data.aws_iam_policy_document.backup_s3.json
}

resource "aws_iam_role" "iam_backup_role" {
  name               = "${data.terraform_remote_state.eks.outputs.cluster_name}-backup-role"
  assume_role_policy = templatefile("policies/oidc_assume_role_policy.json", {
    OIDC_ARN = data.terraform_remote_state.eks.outputs.oidc_provider_arn,
	OIDC_URL = data.terraform_remote_state.eks.outputs.oidc_provider,
	NAMESPACE = kubernetes_namespace.postgresql.id,
	SA_NAME = "cluster-sa" })

  tags = merge(
    {
      "ServiceAccountName"      = "cluster-sa"
      "ServiceAccountNameSpace" = kubernetes_namespace.postgresql.id
    }
  )
}

resource "aws_iam_role_policy_attachment" "iam_backup_policy_attachement" {
  role       = aws_iam_role.iam_backup_role.name
  policy_arn = aws_iam_policy.backup_policy.arn
}

resource "kubernetes_service_account" "cluster-sa" {
  automount_service_account_token = true
  metadata {
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.iam_backup_role.arn
    }
    labels = {
      "app.kubernetes.io/managed-by" = "terraform"
      "app.kubernetes.io/name"       = "cluster-sa"
    }
    name      = "cluster-sa"
    namespace = kubernetes_namespace.postgresql.id
  }
}

resource "kubernetes_namespace" "postgresql" {
  metadata {
    annotations = {
      name = "postgresql"
    }

    name = "postgresql"
  }
}
