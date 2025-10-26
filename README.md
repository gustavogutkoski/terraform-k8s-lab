# Terraform Kubernetes Lab

This project demonstrates how to provision a local Kubernetes cluster using Kind (Kubernetes in Docker) and deploy applications using Terraform.

## Prerequisites

Ensure you have the following tools installed on your system:

- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [Docker](https://docs.docker.com/get-docker/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation) (Optional)

> **Note on Kind Installation**: The Terraform provider for Kind (`tehcyx/kind`) will automatically download and use its own version of the `kind` executable. Therefore, you do not need to install `kind` manually for Terraform to work. However, installing it is recommended for interacting with your cluster directly (e.g., `kind get clusters`).

## Configuring the Kind Cluster

The default configuration for the cluster is minimal and only sets the cluster name. You can add more advanced configurations, such as port mappings, by modifying the `kind_cluster` resource within the `modules/k8s-kind/main.tf` file.

For example, to map port `8080` on your local machine to port `80` on the cluster's control-plane node, you can add a `kind_config` block like this:

**File: `modules/k8s-kind/main.tf`**
```terraform
resource "kind_cluster" "this" {
  name           = var.cluster_name
  wait_for_ready = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"
    node {
      role = "control-plane"
      extra_port_mappings {
        container_port = 80
        host_port      = 8080
        protocol       = "TCP"
      }
    }
  }
}
```

After modifying the module, you would need to run `terraform apply` again in the root directory to update the cluster with the new configuration.

## Project Structure

The repository is organized into two main parts:

- **Root Directory (`./`)**: This contains the Terraform configuration to provision the Kind cluster itself. It uses the `tehcyx/kind` provider to create the cluster and outputs the path to the generated `kubeconfig` file.
- **`k8s-manifests/`**: This directory contains the Terraform configuration to deploy Kubernetes resources (an Nginx deployment and service) onto the cluster. It uses the `hashicorp/kubernetes` provider, which is configured by the `kubeconfig` file from the first stage.

## Usage

Follow these steps to create the cluster and deploy the applications.

### Stage 1: Provision the Kind Cluster

1.  **Navigate to the project root directory.**
    ```bash
    cd terraform-k8s-lab
    ```

2.  **Initialize Terraform.** This will download the necessary providers.
    ```bash
    terraform init
    ```

3.  **Apply the configuration to create the cluster.**
    ```bash
    terraform apply
    ```
    Confirm the action by typing `yes`. After the command completes, Terraform will display the `kubeconfig_path` output. **Copy this path for the next stage.**

### Stage 2: Deploy Kubernetes Resources

1.  **Navigate to the `k8s-manifests` directory.**
    ```bash
    cd k8s-manifests
    ```

2.  **Initialize Terraform.**
    ```bash
    terraform init
    ```

3.  **Apply the configuration, passing the kubeconfig path.**
    Replace `"/path/to/your/kubeconfig"` with the actual path you copied from Stage 1.
    ```bash
    terraform apply -var="kubeconfig_path=/path/to/your/kubeconfig"
    ```
    Confirm the action by typing `yes`. This will deploy the Nginx resources to your Kind cluster.

## Verification

To verify that the resources have been deployed successfully, you can use `kubectl`.

1.  **Set the `KUBECONFIG` environment variable** to point to your new cluster's configuration file.
    ```bash
    export KUBECONFIG="/path/to/your/kubeconfig"
    ```

2.  **Check the cluster nodes.**
    ```bash
    kubectl get nodes
    ```
    You should see the control-plane node for your `playground-k8s` cluster in a `Ready` state.

3.  **Check the Nginx deployment and service.**
    ```bash
    kubectl get deployment,svc -n default
    ```
    You should see the `nginx-deployment` and the `nginx-svc` service listed.

## Cleaning Up

To destroy the resources and tear down the environment, you must run the `destroy` command in each stage, in the reverse order of creation.

1.  **Destroy the Kubernetes resources.**
    Navigate to the `k8s-manifests` directory and run:
    ```bash
    terraform destroy -var="kubeconfig_path=/path/to/your/kubeconfig"
    ```

2.  **Destroy the Kind cluster.**
    Navigate back to the root directory and run:
    ```bash
    terraform destroy
    ```
