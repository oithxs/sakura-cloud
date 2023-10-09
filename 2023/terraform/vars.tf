variable "server_num" {
  default = 3
}

variable "server_password" {}

variable "discord_webhook_url" {}

locals {
  local_ssh_public_key = file("~/.ssh/id_ed25519.pub")
}
