output "kubeconfig_path" {
  description = "The path to the kubeconfig file for the created Kind cluster."
  value       = module.k8s_kind.kubeconfig_path
}
