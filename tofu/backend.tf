terraform {
  required_version = ">= 1.8"
  backend "s3" {
    bucket         = "bstuart-tf-state"
    key            = "${var.project_name}/${var.module_name}/terraform.tfstate"
    dynamodb_table = "tf-state-locking-table"
    region         = "eu-west-1"
  }
}
