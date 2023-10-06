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
    disable_pw_auth = true
    ssh_keys        = [local.local_ssh_public_key]
  }
}
