
# main.tf
module "eks_cluster" {
    source           = "./modules/eks_cluster"
    eks_cluster_name = var.cluster_name
}



# modules/gke_cluster/outputs.tf
output "gke_cluster_name" {
    value = google_container_cluster.wafi_cluster.name
}