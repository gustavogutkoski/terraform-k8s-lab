module "k8s_kind" {
  source       = "./modules/k8s-kind"
  cluster_name = "playground-k8s"
  worker_nodes = 2
}
