output "name" {
  value = "${google_compute_network.default.name}"
}

output "self_link" {
  value = "${google_compute_network.default.self_link}"
}

output "ip_cidr_range" {
  value = "${google_compute_subnetwork.default.ip_cidr_range}"
}

output "subnet_name" {
  value = "${google_compute_subnetwork.default.name}"
}

output "subnet_self_link" {
  value = "${google_compute_subnetwork.default.self_link}"
}
