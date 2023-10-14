variable "server_num" {
  default = 3
}

variable "cloudflare_account_id" {}
variable "cloudflare_r2_bucket_name" {
  default = "hxs-sacloud"
}

variable "server_password" {}

variable "discord_webhook_url" {}

locals {
  local_ssh_public_key = file("~/.ssh/id_ed25519.pub")
}
