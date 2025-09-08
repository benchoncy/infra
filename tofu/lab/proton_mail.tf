resource "cloudflare_record" "proton_verification" {
  zone_id = data.cloudflare_zone.domain.id
  name    = "@"
  type    = "TXT"
  ttl     = 3600
  content = "protonmail-verification=cdc4185260891b2febee6bba685c071cafc92faa"
  comment = "Proton verification record"
}

resource "cloudflare_record" "proton_mx1" {
  zone_id  = data.cloudflare_zone.domain.id
  name     = "@"
  type     = "MX"
  ttl      = 14400
  priority = 10
  content  = "mail.protonmail.ch"
  comment  = "Proton MX1 record"
}

resource "cloudflare_record" "proton_mx2" {
  zone_id  = data.cloudflare_zone.domain.id
  name     = "@"
  type     = "MX"
  ttl      = 14400
  priority = 20
  content  = "mailsec.protonmail.ch"
  comment  = "Proton MX2 record"
}

resource "cloudflare_record" "proton_spf" {
  zone_id = data.cloudflare_zone.domain.id
  name    = "@"
  type    = "TXT"
  ttl     = 3600
  content = "v=spf1 include:_spf.protonmail.ch ~all"
  comment = "Proton spf record"
}

resource "cloudflare_record" "proton_dkim1" {
  zone_id = data.cloudflare_zone.domain.id
  name    = "protonmail._domainkey.benstuart.ie"
  type    = "CNAME"
  ttl     = 3600
  content = "protonmail.domainkey.dsiqtmct7rfhjfqmwx42vdk6hij6yqsvwmeql52hufheh2tir5jla.domains.proton.ch."
  comment = "Proton DKIM1 record"
}

resource "cloudflare_record" "proton_dkim2" {
  zone_id = data.cloudflare_zone.domain.id
  name    = "protonmail2._domainkey.benstuart.ie"
  type    = "CNAME"
  ttl     = 3600
  content = "protonmail2.domainkey.dsiqtmct7rfhjfqmwx42vdk6hij6yqsvwmeql52hufheh2tir5jla.domains.proton.ch."
  comment = "Proton DKIM2 record"
}

resource "cloudflare_record" "proton_dkim3" {
  zone_id = data.cloudflare_zone.domain.id
  name    = "protonmail3._domainkey.benstuart.ie"
  type    = "CNAME"
  ttl     = 3600
  content = "protonmail3.domainkey.dsiqtmct7rfhjfqmwx42vdk6hij6yqsvwmeql52hufheh2tir5jla.domains.proton.ch."
  comment = "Proton DKIM3 record"
}

resource "cloudflare_record" "proton_dmarc" {
  zone_id = data.cloudflare_zone.domain.id
  name    = "_dmarc.benstuart.ie"
  type    = "TXT"
  ttl     = 3600
  content = "v=DMARC1; p=quarantine"
  comment = "Proton DMARC record"
}

