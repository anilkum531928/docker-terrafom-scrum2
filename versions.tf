terraform {
  required_version = ">= 1.10.0"

  # This bucket is in us-east-1. It stores state independently of the region
  # where the AWS infrastructure is deployed.
  backend "s3" {
    bucket       = "terraform-demo-531928"
    key          = "network/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = var.tags
  }
}
