terraform {
  required_version = "~> 1.0.0"
  required_providers {

    genesyscloud = {
      source  = "genesys.com/mypurecloud/genesyscloud"
      version = "0.1.0"
    }
  }
}
