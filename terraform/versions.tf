terraform {
  required_version = ">= 1.6"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.0, < 7.0"
    }
  }

  # Partial configuration: terraform init -backend-config="bucket=<state-bucket>"
  backend "gcs" {
    prefix = "gke-gitops-platform"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}
