resource "cloudflare_record" "zoho_spf" {
  zone_id = module.cloud_bootstrap.cf_zone_id
  name    = "@"
  type    = "TXT"
  ttl     = 3600
  content = "v=spf1 include:zoho.eu ~all"
  comment = "Zoho Mail SPF record"
}

resource "cloudflare_record" "zoho_dmarc" {
  zone_id = module.cloud_bootstrap.cf_zone_id
  name    = "_dmarc.benstuart.ie"
  type    = "TXT"
  ttl     = 3600
  content = "v=DMARC1; p=none; rua=mailto:ben@benstuart.ie; ruf=mailto:ben@benstuart.ie; sp=none; adkim=r; aspf=r; pct=100"
  comment = "Zoho Mail DMARC record"
}

resource "cloudflare_record" "zoho_dkim" {
  zone_id = module.cloud_bootstrap.cf_zone_id
  name    = "benstuart._domainkey.benstuart.ie"
  type    = "TXT"
  ttl     = 3600
  content = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCGV4LFVkDrbKoIVg6ZiW+l2G7J4SzXN3aUgmV6Rq5IpvinHr2GHxHHc5bZ0m6OlUJbE/VzBKIH0TS8V1fDhD3E86QO6NKvCuRl3QKx/MW5w8Ro0w85f0/tffVjm5MaWrT8OxKr8+nTdIsZj3xQdcI5HX2atp/ybUPOLllN/OtA5wIDAQAB"
  comment = "Zoho Mail DKIM record"
}

resource "cloudflare_record" "zoho_mx1" {
  zone_id  = module.cloud_bootstrap.cf_zone_id
  name     = "@"
  type     = "MX"
  ttl      = 14400
  priority = 10
  content  = "mx.zoho.eu."
  comment  = "Zoho Mail MX1 record"
}

resource "cloudflare_record" "zoho_mx2" {
  zone_id  = module.cloud_bootstrap.cf_zone_id
  name     = "@"
  type     = "MX"
  ttl      = 14400
  priority = 20
  content  = "mx2.zoho.eu."
  comment  = "Zoho Mail MX2 record"
}

resource "cloudflare_record" "zoho_mx3" {
  zone_id  = module.cloud_bootstrap.cf_zone_id
  name     = "@"
  type     = "MX"
  ttl      = 14400
  priority = 50
  content  = "mx3.zoho.eu."
  comment  = "Zoho Mail MX3 record"
}
