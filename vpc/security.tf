resource "google_compute_firewall" "allow-all-internal" {
  name    = "allow-all-internal"
  network = "${google_compute_network.default.self_link}"

  allow {
    protocol = "all"
  }

  source_ranges = ["${var.ip_cidr_range}"]
}
