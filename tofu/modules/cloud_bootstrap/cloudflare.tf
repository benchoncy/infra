data "cloudflare_accounts" "main" {
  name = var.cf_account_name
}

resource "cloudflare_zone" "main" {
  account_id = data.cloudflare_accounts.main.accounts[0].id
  zone       = var.cf_root_domain
}

output "cf_zone_id" {
  value = cloudflare_zone.main.id
}
