terraform {
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
      version = "2.0.2"
    }
  }
}
provider "vsphere" {
  user              = var.user
  password          = var.password
  vsphere_server    = var.vsphere_server

  allow_unverified_ssl = true
}