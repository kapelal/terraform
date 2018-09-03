output "name" {
  value = "${google_dns_managed_zone.default.name}"
}

output "dns_name" {
  value = "${google_dns_managed_zone.default.dns_name}"
}

output "name_servers" {
  value = "${google_dns_managed_zone.default.name_servers}"
}

output "kapelal_ip" {
  value = "${google_compute_address.kapelal-ip.address}"
}
