resource "digitalocean_project" "main" {
  name        = "Default"
  description = "A default project for my services"
  purpose     = "Personal"
  environment = "Production"
  is_default  = true
}
