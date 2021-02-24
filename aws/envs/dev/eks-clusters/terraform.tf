terraform {
  backend "s3" {
    bucket = "hass-tf-remote-state"
    key    = "dev/eks-clusters/"
    region = "ap-southeast-1"
  }
}