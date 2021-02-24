# data "terraform_remote_state" "iota_hass_vpc" {
#   backend = "s3"
#   config  = {
#     region  = "ap-southeast-1"
#     bucket  = "hass-tf-remote-state"
#     key     = "infra/vpc/terraform.tfstate"
#   }
# }

# data "terraform_remote_state" "policies_arn" {
#   backend = "s3"
#   config  = {
#     region  = "ap-southeast-1"
#     bucket  = "hass-tf-remote-state"
#     key     = "infra/iam/policies/terraform.tfstate"
#   }
# }
