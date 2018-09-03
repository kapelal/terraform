provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
}

terraform {
  backend "gcs" {
    prefix = "dns"
  }

  required_version = "= 0.11.3"
}

data "terraform_remote_state" "infra_vpc" {
  backend = "gcs"

  config {
    bucket = "${var.bucket}"
    prefix = "vpc"
  }
}

resource "google_dns_managed_zone" "default" {
  name     = "${var.name}"
  dns_name = "${var.dns_name}"
}

resource "google_dns_record_set" "kapelal-dns-record" {
  managed_zone = "${google_dns_managed_zone.default.name}"
  name         = "kapelal.io."
  type         = "A"
  ttl          = 1800
  rrdatas      = ["${google_compute_address.kapelal-ip.address}"]
}
