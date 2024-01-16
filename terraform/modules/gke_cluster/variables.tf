variable "cluster_name" {
    description = "Name of the GKE cluster"
    type        = string
    default     = "wafi-gke-cluster"
}

variable "region" {
    description = "Google Cloud region"
    type        = string
    default     = "us-central1"
}