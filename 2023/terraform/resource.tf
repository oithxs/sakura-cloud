resource "sakuracloud_switch" "switch" {
  name = "hxs-shared-switch"
}

resource "sakuracloud_disk" "disk" {
  count = var.server_num

  name              = "hxs-shared-disk-${count.index}"
  plan              = "ssd"
  size              = 20
  source_archive_id = data.sakuracloud_archive.ubuntu2204.id
}

resource "sakuracloud_server" "server" {
  count = var.server_num

  name  = "hxs-shared-server-${count.index}"
  disks = [element(sakuracloud_disk.disk.*.id, count.index)]

  core   = 2
  memory = 4

  network_interface {
    upstream = "shared"
  }

  network_interface {
    upstream = sakuracloud_switch.switch.id
  }

  disk_edit_parameter {
    hostname        = "hxs-shared-server-${count.index}"
    password        = var.server_password
    disable_pw_auth = true
    ssh_keys        = [local.local_ssh_public_key]
  }
}

resource "sakuracloud_simple_monitor" "monitor" {
  count = var.server_num

  delay_loop = 60
  timeout    = 10

  max_check_attempts = 3
  target             = element(sakuracloud_server.server.*.ip_address, count.index)

  health_check {
    protocol = "ping"
  }

  description = element(sakuracloud_server.server.*.name, count.index)

  notify_email_enabled = false
  notify_slack_enabled = true
  notify_slack_webhook = "${var.discord_webhook_url}/slack"
}
