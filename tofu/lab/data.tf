data "cloudflare_zone" "domain" {
  name = var.root_domain
}
