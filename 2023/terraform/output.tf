output "server_name" {
  value = sakuracloud_server.server.*.name
}

output "ip_address" {
  value = sakuracloud_server.server.*.ip_address
}
