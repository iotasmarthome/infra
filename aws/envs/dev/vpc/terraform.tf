terraform {
  backend "s3" {
    bucket = "hass-tf-remote-state"
    key    = "dev/vpc/"
    region = "ap-southeast-1"
  }
}