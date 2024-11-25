locals {
  project_name        = "infra"
  project_description = "My Homelab and Cloud Infrastructure"
}

terraform {
  backend "s3" {
    bucket         = "bstuart-tf-state"
    key            = "infra.tfstate"
    dynamodb_table = "tf-state-locking-table"
    region         = "eu-west-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }

}
