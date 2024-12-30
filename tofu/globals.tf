data "onepassword_vault" "automation" {
  name = "Automation"
}
variable "module_name" {
  type        = string
  description = "Tofo module name, used mostly for seperation of statefiles"
}

variable "project_name" {
  type        = string
  description = "Name of the project"
  default     = "infra"
}

variable "project_description" {
  type        = string
  description = "Description of the project"
  default     = "My Homelab and Cloud Infrastructure"
}

variable "aws_region" {
  type        = string
  description = "Default AWS region to use"
  default     = "eu-west-1"
}

variable "root_domain" {
  type        = string
  description = "The root domain to use across infrastructure"
  default     = "benstuart.ie"
}

variable "repo_url" {
  type        = string
  description = "URL to this repository"
  default     = "https://github.com/benchoncy/infra"
}
