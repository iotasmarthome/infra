provider "aws" {
  region = "ap-southeast-1"
}

data "aws_eks_cluster" "cluster" {
  name = module.iota_hassio_eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.iota_hassio_eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

module "iota_hassio_eks" {
  source          = "git@github.com:terraform-aws-modules/terraform-aws-eks.git"
  cluster_name    = "iota-hass-eks-001"
  subnets         = data.terraform_remote_state.iota_hass_vpc.outputs.private_subnets
  vpc_id          = data.terraform_remote_state.iota_hass_vpc.outputs.vpc_id

  # subnets         = [
  #   "subnet-0365aa576bafbb5c9",
  #   "subnet-03767bd7ff645b64c",
  # ]
  # vpc_id          = "vpc-094c76090c5b3445f"
  
  cluster_version = "1.16"
  cluster_endpoint_private_access = true

  worker_groups_launch_template = [
    {
      name                  = "on-demand-0"
      key_name              = "iota-hass"
      instance_type         = "t2.micro"
      asg_min_size          = 1
      asg_desired_capacity  = 1
      asg_max_size          = 1
      autoscaling_enabled   = true
      asg_force_delete      = true
      enable_monitoring     = true
      enabled_metrics       = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity"]
      kubelet_extra_args    = "--node-labels=node.kubernetes.io/lifecycle=normal,node=general"
      suspended_processes   = ["AZRebalance"]
      additional_userdata   = "${local.user_data}"
      tags = [
        {
          "key"                 = "k8s.io/cluster-autoscaler/enabled"
          "propagate_at_launch" = "false"
          "value"               = "true"
        },
        {
          "key"                 = "k8s.io/cluster-autoscaler/hass-eks-001"
          "propagate_at_launch" = "false"
          "value"               = "true"
        }
      ]
    }
  ]

  tags = {
    Terraform         = "true"
    Owner             = "iota"
    Environment       = "dev"
    KubernetesCluster = "hass-eks-001"
  }
}

module "hass_eks_secgr_ssh" {
  source                   = "git@github.com:terraform-aws-modules/terraform-aws-security-group.git"
  name                     = "hass-eks-secgr-ssh"
  use_name_prefix          = false
  vpc_id                   = data.terraform_remote_state.iota_hass_vpc.outputs.vpc_id
  ingress_cidr_blocks      = data.terraform_remote_state.iota_hass_vpc.outputs.vpc_cidr_block
  # vpc_id = "vpc-094c76090c5b3445f"
  # ingress_cidr_blocks = ["10.0.0.0/16"]
  ingress_rules            = ["ssh-tcp", "all-icmp"]
  egress_rules             = ["all-all"]

  tags                     = {
    Name        = "hass-eks-secgr-ssh"
    Terraform   = "true"
    Owner       = "IOTA"
    Environment = "dev"
  }
}
