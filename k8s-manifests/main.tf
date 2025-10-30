resource "kubernetes_manifest" "nginx_deploy" {
  manifest = yamldecode(file("${path.module}/../manifests/nginx/deployment.yaml"))
}

resource "kubernetes_manifest" "nginx_svc" {
  manifest = yamldecode(file("${path.module}/../manifests/nginx/service.yaml"))
}

resource "kubernetes_manifest" "trustscore_api_deploy" {
  manifest = yamldecode(file("${path.module}/../manifests/trustscore-api/deployment.yaml"))
}

resource "kubernetes_manifest" "trustscore_api_svc" {
  manifest = yamldecode(file("${path.module}/../manifests/trustscore-api/service.yaml"))
}

resource "kubernetes_manifest" "postgres_configmap" {
  manifest = yamldecode(file("${path.module}/../manifests/postgres/configmap.yaml"))
}

resource "kubernetes_manifest" "postgres_secret" {
  manifest = yamldecode(file("${path.module}/../manifests/postgres/secret.yaml"))
}

resource "kubernetes_manifest" "postgres_pvc" {
  manifest = yamldecode(file("${path.module}/../manifests/postgres/pvc.yaml"))
}

resource "kubernetes_manifest" "postgres_deploy" {
  manifest = yamldecode(file("${path.module}/../manifests/postgres/deployment.yaml"))
  
  depends_on = [
    kubernetes_manifest.postgres_configmap,
    kubernetes_manifest.postgres_secret,
    kubernetes_manifest.postgres_pvc
  ]
}

resource "kubernetes_manifest" "postgres_svc" {
  manifest = yamldecode(file("${path.module}/../manifests/postgres/service.yaml"))
}
