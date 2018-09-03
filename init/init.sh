#!/usr/bin/env bash

gsutil mb -l eu gs://kapelal-203808
gsutil versioning set on gs://kapelal-203808

gcloud services enable compute.googleapis.com dns.googleapis.com container.googleapis.com containerregistry.googleapis.com
