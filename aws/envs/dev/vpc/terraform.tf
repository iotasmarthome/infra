terraform {
  backend "s3" {
    bucket = "tfstate"
    key    = "dev/vpc/"
    region = "ap-southeast-1"
  }
}