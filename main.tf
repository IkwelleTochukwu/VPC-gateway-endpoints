provider "aws" {
  profile = "default"
  region  = local.region

}


locals {

  name   = var.module_name
  region = var.aws_region
  tags   = var.tags

}

