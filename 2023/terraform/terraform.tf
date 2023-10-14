terraform {
  required_providers {
    sakuracloud = {
      source  = "sacloud/sakuracloud"
      version = "2.24.1"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket                      = "hxs-sacloud"
    key                         = "terraform.tfstate"
    region                      = "apac"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    use_path_style              = true
  }
}

provider "sakuracloud" {
  api_request_timeout = "3600"
}

provider "cloudflare" {}
