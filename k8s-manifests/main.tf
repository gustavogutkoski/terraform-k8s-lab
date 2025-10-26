resource "kubernetes_manifest" "nginx_deploy" {
  manifest = yamldecode(file("${path.module}/../manifests/deployment.yaml"))
}

resource "kubernetes_manifest" "nginx_svc" {
  manifest = yamldecode(file("${path.module}/../manifests/service.yaml"))
}
