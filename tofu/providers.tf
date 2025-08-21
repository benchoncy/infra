data "onepassword_item" "aws_creds" {
  vault = data.onepassword_vault.automation.uuid
  title = "AWS Automation User"
}

data "onepassword_item" "cf_creds" {
  vault = data.onepassword_vault.automation.uuid
  title = "Cloudflare Automation Token"
}

data "onepassword_item" "grafana_creds" {
  vault = data.onepassword_vault.automation.uuid
  title = "Grafana Cloud Stack"
}

data "onepassword_item" "do_creds" {
  vault = data.onepassword_vault.automation.uuid
  title = "Digital Ocean API Key"
}

terraform {
  required_providers {
    onepassword = {
      source  = "1password/onepassword"
      version = "2.1.2"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "onepassword" {
  account = "my.1password.com"
}

provider "aws" {
  region     = var.aws_region
  access_key = data.onepassword_item.aws_creds.section[0].field[0].value
  secret_key = data.onepassword_item.aws_creds.section[0].field[1].value

  default_tags {
    tags = {
      Project   = var.project_name
      Purpose   = var.project_description
      Module    = local.module_name
      Repo      = var.repo_url
      ManagedBy = "OpenTofu"
    }
  }
}

provider "cloudflare" {
  api_token = data.onepassword_item.cf_creds.password
}

provider "digitalocean" {
  token = data.onepassword_item.do_creds.credential
}
