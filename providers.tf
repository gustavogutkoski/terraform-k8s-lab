terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.30.0"
    }
    kind = {
      source  = "tehcyx/kind"
      version = "~> 0.2.0"
    }
  }
}



provider "kind" {}
