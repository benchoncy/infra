data "onepassword_item" "cf_bootstrap" {
  vault = data.onepassword_vault.automation.uuid
  title = "Cloudflare Bootstrap Token"
}

provider "cloudflare" {
  alias     = "bootstrap"
  api_token = data.onepassword_item.cf_bootstrap.credential
}

data "cloudflare_accounts" "main" {
  provider = cloudflare.bootstrap
}
data "cloudflare_api_token_permission_groups" "all" {
  provider = cloudflare.bootstrap
}

resource "cloudflare_zone" "main" {
  provider = cloudflare.bootstrap

  account_id = data.cloudflare_accounts.main.accounts[0].id
  zone       = var.root_domain
}

resource "cloudflare_api_token" "main" {
  provider = cloudflare.bootstrap

  name = "automation-token"

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.account["Account Settings Read"],
      data.cloudflare_api_token_permission_groups.all.zone["DNS Write"],
      data.cloudflare_api_token_permission_groups.all.zone["Zone Write"]
    ]

    resources = {
      "com.cloudflare.api.account.*" = "*"
    }
  }
}

resource "onepassword_item" "cf_token" {
  vault = data.onepassword_vault.automation.uuid

  title    = "Cloudflare Automation Token"
  category = "login"

  password = cloudflare_api_token.main.value

  tags = ["ManagedBy:OpenTofu"]
}
