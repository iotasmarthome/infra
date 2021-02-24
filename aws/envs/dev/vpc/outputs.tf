# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.aws_iota_hass_eks_vpc.vpc_id
}

# CIDR blocks
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.aws_iota_hass_eks_vpc.vpc_cidr_block
}

# Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.aws_iota_hass_eks_vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.aws_iota_hass_eks_vpc.public_subnets
}

# NAT gateways
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.aws_iota_hass_eks_vpc.nat_public_ips
}

# AZs
output "azs" {
  description = "A list of availability zones spefified as argument to this module"
  value       = module.aws_iota_hass_eks_vpc.azs
}

