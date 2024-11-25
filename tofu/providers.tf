provider "aws" {
  region = "eu-west-1"
  default_tags {
    tags = {
      Project   = local.project_name
      Purpose   = local.project_description
      Repo      = "https://github.com/benchoncy/${local.project_name}"
      ManagedBy = "OpenTofu"
    }
  }
}
