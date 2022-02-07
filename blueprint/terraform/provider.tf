terraform {
  required_version = "~> 1.0.0"
  required_providers {
    archive = {
      version = ">= 2.0"
      source  = "hashicorp/archive"
    }

    genesyscloud = {
      source  = "genesys.com/mypurecloud/genesyscloud"
      version = "0.1.0"
    }
  }
}

provider "genesyscloud" {
  sdk_debug = true
}
