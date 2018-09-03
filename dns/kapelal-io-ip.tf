resource "google_compute_address" "kapelal-ip" {
  region = "${var.region}"
  name   = "${var.ip_name}"
}
