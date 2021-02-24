provider "aws" {
  region = "ap-southeast-1"
}

module "aws_iota_hass_eks_vpc" {
  source  = "git@github.com:terraform-aws-modules/terraform-aws-vpc.git"
  name    = "iota-has-eks-vpc"
  cidr    = "10.0.0.0/16"
  # cidr    = "100.68.16.0/21"

  azs             = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.0.0/24"]
  # private_subnets = ["100.68.16.0/24", "100.68.17.0/24", "100.68.18.0/24", "100.68.19.0/24", "100.68.20.0/24", "100.68.21.0/24"]
  # public_subnets  = ["100.68.22.0/24", "100.68.23.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false
  enable_vpn_gateway   = false
  enable_dns_hostnames = true

  # enable_dynamodb_endpoint = true
  # enable_kms_endpoint = true
  # kms_endpoint_private_dns_enabled = true

  tags = {
		Terraform = "true"
    Owner = "iota"
    Environment = "iota-hass"
    KubernetesCluster = "iota-hass-eks-001"
	}
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
    KubernetesCluster = "iota-hass-eks-001"
  }
  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
    KubernetesCluster = "iota-hass-eks-001"
  }
}

# data "aws_subnet_ids" "ap-southeast-1a" {
#   vpc_id = "${module.aws_iota_hass_eks_vpc.vpc_id}"
#   tags = {
#     Name = "iota-hass-eks-vpc-private-ap-southeast-1a"
#   }
# }
# data "aws_subnet_ids" "ap-southeast-1b" {
#   vpc_id = "${module.aws_iota_hass_eks_vpc.vpc_id}"
#   tags = {
#     Name = "iota-hass-eks-vpc-private-ap-southeast-1b"
#   }
# }
# data "aws_subnet_ids" "ap-southeast-1c" {
#   vpc_id = "${module.aws_iota_hass_eks_vpc.vpc_id}"
#   tags = {
#     Name = "iota-hass-eks-vpc-private-ap-southeast-1c"
#   }
# }


# provider "aws" {
#   region = "ap-southeast-1"
# }

# module "vpc" {
#   source = "../../"

#   name = "hass-vpc"

#   cidr = "10.0.0.0/16"

#   azs             = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
#   private_subnets = ["10.0.1.0/24"]
#   public_subnets  = ["10.0.0.0/24"]

#   enable_ipv6 = false

#   enable_nat_gateway = true
#   single_nat_gateway = true

#   public_subnet_tags = {
#     Name = "overridden-name-public"
#   }

#   tags = {
#     Owner       = "IOTA"
#     Environment = "dev"
#   }

#   vpc_tags = {
#     Name = "hass-vpc"
#   }
# }

