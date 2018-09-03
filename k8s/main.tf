provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
}

terraform {
  backend "gcs" {
    prefix = "k8s"
  }

  required_version = "= 0.11.3"
}

data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config {
    bucket = "${var.bucket}"
    prefix = "vpc"
  }
}

data "google_compute_zones" "available" {}

resource "google_container_cluster" "default" {
  name               = "${var.project}"
  network            = "${data.terraform_remote_state.vpc.name}"
  subnetwork         = "${data.terraform_remote_state.vpc.subnet_name}"
  zone               = "${data.google_compute_zones.available.names[0]}"
  min_master_version = "${var.min_master_version}"
  node_version       = "${var.node_version}"

  lifecycle {
    ignore_changes = ["node_pool"]
  }

  node_pool = {
    name       = "void-pool"
    node_count = "0"
  }

  additional_zones = ["${slice(data.google_compute_zones.available.names, 2, 3)}"]

  maintenance_policy {
    daily_maintenance_window {
      start_time = "02:00"
    }
  }

  addons_config {
    http_load_balancing {
      disabled = "true"
    }

    horizontal_pod_autoscaling {
      disabled = "true"
    }

    kubernetes_dashboard {
      disabled = "true"
    }
  }
}

resource "google_container_node_pool" "pool" {
  name        = "default"
  zone        = "${data.google_compute_zones.available.names[0]}"
  cluster     = "${google_container_cluster.default.name}"
  node_count  = "${var.default_node_count}"

  node_config {
    machine_type = "${var.default_machine_type}"
    disk_size_gb = "${var.default_disk_size_gb}"

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    preemptible = "${var.preemptible}"
  }

  management {
    auto_repair  = "true"
    auto_upgrade = "false"
  }
}
