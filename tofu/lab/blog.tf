locals {
  blog_domain_list = toset(["@", "www", "blog"])
  blog_ingress     = replace(digitalocean_app.blog-site.default_ingress, "https://", "")
}

resource "digitalocean_app" "blog-site" {
  spec {
    name   = "blog"
    region = "ams"

    static_site {
      name             = "blog-staticsite"
      build_command    = "hugo -d ./public"
      source_dir       = "/src"
      environment_slug = "hugo"

      github {
        repo           = "benchoncy/my-blog-site"
        branch         = "main"
        deploy_on_push = true
      }
    }

    dynamic "domain" {
      for_each = local.blog_domain_list

      content {
        name = domain.value == "@" ? "${var.root_domain}" : "${domain.value}.${var.root_domain}"
      }
    }

    alert {
      rule = "DEPLOYMENT_FAILED"
    }

    alert {
      rule = "DOMAIN_FAILED"
    }
  }
}

resource "cloudflare_record" "extra" {
  for_each = local.blog_domain_list

  zone_id = data.cloudflare_zone.domain.id
  name    = each.value == "@" ? "@" : "${each.value}.${var.root_domain}"
  type    = "CNAME"
  ttl     = 3600
  content = local.blog_ingress
  comment = "Blog site record"
}
