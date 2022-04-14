data "ibm_resource_group" "rg" {
  name     = var.rg_name
}

resource "random_string" "random" {
  length           = 5
  special          = false
}

locals {
  cr_namespace = lower("${var.env_prefix}-${var.rg_name}-ns")
}