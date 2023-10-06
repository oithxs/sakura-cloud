variable "server_num" {
  default = 3
}

locals {
  local_ssh_public_key = file("~/.ssh/id_ed25519.pub")
}
