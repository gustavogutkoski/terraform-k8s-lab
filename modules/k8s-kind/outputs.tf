output "kind_cluster" {
  value = kind_cluster.this
}

output "kubeconfig_path" {
  value = kind_cluster.this.kubeconfig_path
}

output "name" {
  value = kind_cluster.this.name
}