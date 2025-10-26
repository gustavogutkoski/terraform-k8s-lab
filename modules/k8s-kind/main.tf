terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "~> 0.2.0"
    }
  }
}

resource "kind_cluster" "this" {
  name           = var.cluster_name
  wait_for_ready = true
}

