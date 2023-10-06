terraform {
  required_providers {
    sakuracloud = {
      source  = "sacloud/sakuracloud"
      version = "2.24.1"
    }
  }
}

provider "sakuracloud" {
  api_request_timeout = "3600"
}
