locals {
  vpc_cidr            = var.vpc_cidr[terraform.workspace]
  vpc_secondary_cidrs = var.vpc_secondary_cidrs[terraform.workspace]
  azs                 = slice(data.aws_availability_zones.eu-central-1.names, 0, 3)

  project_tags = {
    "terrarom" = "true"
  }
}

data "aws_availability_zones" "eu-central-1" {
  state = "available"
}

resource "aws_eip" "nat" {
  count = 3

  tags = merge(local.project_tags, {
    Name = "${var.id}-${terraform.workspace}-ec1-nat-${count.index}"
  })
}

module "vpc-ec1" {
  #  source  = "terraform-aws-modules/vpc/aws"
  #  version = "5.8.1"
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=25322b6"

  name                  = "${var.id}-${terraform.workspace}-ec1-vpc"
  cidr                  = local.vpc_cidr
  secondary_cidr_blocks = local.vpc_secondary_cidrs

  azs = local.azs

  private_subnets = concat(
    [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)],
  )
  public_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 48)]
  intra_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 52)]

  enable_nat_gateway     = true # Enable NAT gateway creation
  one_nat_gateway_per_az = true # Ensure that there is a NAT gateway in each Availability Zone

  reuse_nat_ips       = true
  external_nat_ip_ids = aws_eip.nat.*.id

  enable_dns_hostnames = true
  enable_dns_support   = true

  manage_default_security_group  = true
  default_security_group_ingress = []
  default_security_group_egress  = []

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = merge(local.project_tags)
}

resource "aws_subnet" "private_pods" {
  count = length(module.vpc-ec1.private_subnets[*])

  vpc_id            = module.vpc-ec1.vpc_id
  cidr_block        = cidrsubnet(element(local.vpc_secondary_cidrs, 0), 2, count.index, )
  availability_zone = local.azs[count.index]

  tags = merge(
    local.project_tags,
    {
      Name  = "${module.vpc-ec1.name}-private-pods-${local.azs[count.index]}",
      Usage = "pods"
    }
  )
}

# associate the pod subnet with the private routetable from its AZ
resource "aws_route_table_association" "private_pods" {
  count = length(module.vpc-ec1.private_subnets[*])

  subnet_id      = aws_subnet.private_pods[count.index].id
  route_table_id = module.vpc-ec1.private_route_table_ids[count.index]
}
