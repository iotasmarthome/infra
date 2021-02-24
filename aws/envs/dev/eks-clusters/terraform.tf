terraform {
  backend "s3" {
    bucket = "tfstate"
    key    = "dev/eks-clusters/"
    region = "ap-southeast-1"
  }
}