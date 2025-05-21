terraform {
  required_providers {
    archive = {
      version = ">= 2.0"
      source  = "hashicorp/archive"
    }

    genesyscloud = {
      source  = "mypurecloud/genesyscloud"
      version = "1.62.0"
    }
  }
}

provider "genesyscloud" {
  sdk_debug = true
}
