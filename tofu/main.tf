module "cloud_bootstrap" {
  source = "./modules/cloud_bootstrap"

  cf_account_name = "benstuart"
  cf_root_domain  = var.root_domain
}
