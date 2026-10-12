variable "project_id" {
  description = "GCP project ID."
  type        = string
}

variable "region" {
  description = "Region for the network and Artifact Registry."
  type        = string
  default     = "asia-south1"
}

variable "zone" {
  description = "Zone for the (zonal) GKE cluster. Zonal keeps the demo cheap."
  type        = string
  default     = "asia-south1-a"
}

variable "cluster_name" {
  description = "GKE cluster name."
  type        = string
  default     = "gitops-platform"
}

variable "master_authorized_cidr" {
  description = "CIDR allowed to reach the Kubernetes API (for example your public IP /32)."
  type        = string
}

variable "machine_type" {
  description = "Node machine type."
  type        = string
  default     = "e2-standard-4"
}

variable "min_nodes" {
  description = "Minimum nodes in the node pool."
  type        = number
  default     = 1
}

variable "max_nodes" {
  description = "Maximum nodes in the node pool."
  type        = number
  default     = 4
}

variable "deletion_protection" {
  description = "Protect the cluster from terraform destroy. Keep true outside demos."
  type        = bool
  default     = false
}
