# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc-ec1.vpc_id
}

# Subnets
output "private_subnets_pods" {
  description = "List of IDs of private subnets pods"
  value       = aws_subnet.private_pods[*].id
}

output "private_subnets_intra" {
  description = "List of IDs of private subnets intra"
  value       = module.vpc-ec1.intra_subnets
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc-ec1.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc-ec1.public_subnets
}

output "vpc_cidr" {
  description = "VPC CIDR block"
  value       = module.vpc-ec1.vpc_cidr_block
}

output "azs" {
  description = "Availability zones"
  value       = module.vpc-ec1.azs
}

# NAT gateways
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc-ec1.nat_public_ips
}
