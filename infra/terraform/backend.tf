terraform {
  backend "s3" {
    bucket         = "my-terraform-state-baket"
    key            = "eks/terraform.tfstate"
    region         = var.aws_region
    dynamodb_table = "Lock-Files"
    encrypt        = true
  }
}

provider "aws" {
  region  = var.aws_region
}