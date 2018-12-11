provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
}

provider "kubernetes" {
}

terraform {
  backend "gcs" {
    prefix = "service_account"
  }

  required_version = "= 0.11.8"
}

resource "google_service_account" "dns-admin" {
  account_id   = "dns-admin"
  display_name = "dns-admin"
  project = "${var.project}"
}

resource "google_service_account_key" "dns-admin-key" {
  service_account_id = "${google_service_account.dns-admin.name}"
  public_key_type = "TYPE_X509_PEM_FILE"
}

resource "google_project_iam_member" "service-accounts" {
  role   = "roles/dns.admin"
  member = "serviceAccount:${google_service_account.dns-admin.email}"
}

resource "kubernetes_secret" "google-application-credentials" {
  metadata {
    name = "cloud-sa"
    namespace = "reverse-proxy"
  }
  data {
    credentials.json = "${base64decode(google_service_account_key.dns-admin-key.private_key)}"
  }
}
