output "name" {
  value = "${google_container_cluster.default.name}"
}

output "projet" {
  value = "${var.project}"
}

output "zone" {
  value = "${data.google_compute_zones.available.names[0]}"
}

output "endpoint" {
  value = "${google_container_cluster.default.endpoint}"
}

output "client_certificate" {
  value = "${google_container_cluster.default.master_auth.0.client_certificate}"
}

output "client_key" {
  value = "${google_container_cluster.default.master_auth.0.client_key}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.default.master_auth.0.cluster_ca_certificate}"
}
