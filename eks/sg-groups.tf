resource "aws_security_group" "allow_alb" {
  name        = "allow_https-${local.id}-${terraform.workspace}"
  description = "Allow inbound traffic to ${local.id}"
  vpc_id      = data.terraform_remote_state.networking.outputs.vpc_id

  ingress {
    description = "Access to VPN"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.office_ipv4
  }

  ingress {
    description = "TLS from CF"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.clowdflare_ipv4
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.id}-${terraform.workspace}-sg"
  }
}

resource "aws_security_group_rule" "alb_to_eks" {
  description              = "Sg group for ALB linked to EKS"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.allow_alb.id
  security_group_id        = module.eks_vpc_ec1.cluster_security_group_id
}
