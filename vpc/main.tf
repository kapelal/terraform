provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
}

terraform {
  backend "gcs" {
    prefix = "vpc"
  }

  required_version = "= 0.11.3"
}

resource "google_compute_network" "default" {
  name                    = "${var.vpc_name}"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "default" {
  name          = "${var.vpc_name}"
  network       = "${google_compute_network.default.self_link}"
  ip_cidr_range = "${var.ip_cidr_range}"
}
