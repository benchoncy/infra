resource "cloudflare_record" "ha" {
  zone_id = data.cloudflare_zone.domain.id
  name    = "ha.benstuart.ie"
  type    = "CNAME"
  ttl     = 3600
  content = "debyt1domejqtcpiefm5jso2azdachdi.ui.nabu.casa"
  comment = "Home Assistant Cloud record"
}

resource "cloudflare_record" "ha_acme" {
  zone_id = data.cloudflare_zone.domain.id
  name    = "_acme-challenge.ha.benstuart.ie"
  type    = "CNAME"
  ttl     = 3600
  content = "_acme-challenge.debyt1domejqtcpiefm5jso2azdachdi.ui.nabu.casa"
  comment = "Home Assistant Cloud ACME record"
}
