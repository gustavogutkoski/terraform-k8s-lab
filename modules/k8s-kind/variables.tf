variable "cluster_name" {
  type        = string
  description = "kind-playground-k8s"
}


variable "worker_nodes" {
  type        = number
  description = "Number of worker nodes in the cluster"
  default     = 1
}