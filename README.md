# Terraform Kubernetes Lab

This project uses Terraform to provision a local Kubernetes cluster with [Kind](https://kind.sigs.k8s.io/) and deploy sample manifests.

## Prerequisites

You will need to have the following tools installed:

- **Terraform**: [Installation instructions](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- **kubectl**: [Installation instructions](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- **Kind**: [Installation instructions](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)

## How to Run

The project is divided into two main steps:

### 1. Provision the Cluster

In this step, the Kind cluster is created with a configurable control-plane and worker nodes.

```bash
# Initialize Terraform in the root directory
terraform init

# Create the cluster
terraform apply -auto-approve
```

### 2. Deploy the Manifests

After the cluster is created, this step deploys an Nginx `Deployment` and `Service`.

```bash
# Navigate to the manifests directory
cd k8s-manifests

# Initialize Terraform
terraform init

# Deploy the Kubernetes resources
terraform apply -auto-approve
```

## Configuration

You can configure the number of worker nodes in the cluster by editing the `main.tf` file in the project root. Change the `worker_nodes` variable:

```terraform
# main.tf

module "k8s_kind" {
  source       = "./modules/k8s-kind"
  cluster_name = "playground-k8s"
  worker_nodes = 2 # Change this value to the desired number of workers
}
```

## Verification

To verify that the cluster is running and the nodes have been created, use `kubectl`:

```bash
kubectl get nodes
```

## Cleanup

To destroy all resources, run `destroy` in each directory, in reverse order:

```bash
# Destroy the Kubernetes manifests
cd k8s-manifests
terraform destroy -auto-approve

# Go back to the root and destroy the cluster
cd ..
terraform destroy -auto-approve
```
