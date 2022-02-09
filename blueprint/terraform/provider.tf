terraform {
  required_version = "~> 1.0.0"
  required_providers {
    archive = {
      version = ">= 2.0"
      source  = "hashicorp/archive"
    }

    genesyscloud = {
      source = "mypurecloud/genesyscloud"
    }
  }
}

provider "genesyscloud" {
  sdk_debug = true
}
