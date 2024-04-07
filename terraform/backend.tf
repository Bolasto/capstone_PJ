terraform {
  backend "s3" {
    bucket = "capsbuc"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}