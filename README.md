🚀 MLOps Platform Infrastructure Repository

This repository provisions the foundational cloud infrastructure and deploys the core open-source MLOps tool stack on AWS Elastic Kubernetes Service (EKS).

🎯 Goals and Architecture

This IaC setup creates a reproducible, secure, and scalable environment for machine learning workloads, from experimentation to production serving.
Tool	Role	Implementation
Terraform	Provisioning (Day 0)	Creates AWS VPC, Subnets, IAM Roles, S3 Buckets, and the core EKS Cluster with Node Groups (CPU, GPU, Storage).
Ansible	Configuration (Day 1)	Post-provisioning tasks, OS hardening, installing non-containerized tools (like an initial HashiCorp Vault instance) and configuring K8s resources via Helm/YAML.
EKS	Compute/Orchestration	Hosts all MLOps tools (MLflow, DVC, Grafana, ClickHouse) as Kubernetes deployments/services.
Vault	Security	Centralized secrets management for MLflow database credentials, S3/MinIO access keys, and model API keys.

💻 Repository Structure

The code is organized to separate cloud provisioning (Terraform) from configuration management (Ansible) and environment-specific variables.

```

├── environments/
│   ├── dev/
│   │   ├── terraform.tfvars  # Dev-specific variables (smaller instance sizes)
│   │   └── secrets.yml       # Ansible Vault encrypted file
│   └── prod/
│       ├── terraform.tfvars  # Prod-specific variables (Spot instance settings, larger scale)
│       └── secrets.yml
├── terraform/                # Manages AWS Cloud Resources (VPC, EKS, Node Groups, S3)
│   ├── modules/
│   │   ├── eks_cluster/      # EKS cluster definition (uses terraform-aws-modules/eks/aws)
│   │   ├── networking/       # VPC, Subnets, Route Tables
│   │   └── s3_storage/       # MLflow Artifact and DVC Remote Buckets
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf            # Exports EKS Cluster name, VPC ID, etc.
└── ansible/                  # Manages Configuration on EC2/K8s (Helm, Vault setup)
    ├── inventory/
    │   └── ec2_dynamic.yml   # Dynamically generated inventory from Terraform outputs
    ├── roles/
    │   ├── vault_setup/      # Installs/initializes HashiCorp Vault on a dedicated VM
    │   └── k8s_deploy/       # Deploys MLflow, Prometheus/Grafana, Seldon Core via Helm
    └── playbooks/
        └── deploy_k8s_tools.yml
```

⚙️ Prerequisites

    AWS Account and configured CLI credentials with administrative access.

    Tools Installed:

        Terraform (v1.x+)

        Ansible (v2.9+)

        AWS CLI

        kubectl and aws-iam-authenticator

🚀 Deployment Instructions

Phase 1: Provision Infrastructure (Terraform)

This phase creates the network, the S3 backend, and the EKS cluster.

    Initialize Terraform Backend: Set up your remote state (e.g., S3/DynamoDB) for state locking.
    Bash

cd terraform
terraform init -backend-config="bucket=<YOUR_STATE_BUCKET>"

Select Environment: Use the workspace command to target a specific environment (e.g., dev).
Bash

terraform workspace select dev || terraform workspace new dev

Plan and Apply: Review the changes and provision the resources.
Bash

terraform plan -var-file=../environments/dev/terraform.tfvars -out=tfplan
terraform apply tfplan

Configure Kubeconfig: After a successful apply, configure kubectl to connect to the new cluster.
Bash

    # Replace <CLUSTER_NAME> and <REGION> with the Terraform output values
    aws eks update-kubeconfig --name <CLUSTER_NAME> --region <REGION>

Phase 2: Configuration and Application Deployment (Ansible)

This phase configures the non-EKS components (like Vault) and then uses Helm/YAML to install the MLOps stack inside EKS.

    Decrypt Secrets: Use the Ansible Vault password to decrypt environment variables.
    Bash

ansible-vault decrypt environments/dev/secrets.yml

Generate Dynamic Inventory: Run a script (or use the AWS Inventory plugin) to get the EC2 IPs created by Terraform.
Bash

# (Example: Uses an Ansible AWS dynamic inventory plugin)
ansible-inventory -i ansible/inventory/ec2_dynamic.yml --list

Run Playbook: Execute the main playbook, which will install Helm charts for MLflow, Prometheus, etc., on your EKS cluster using kubectl (which is configured via the Terraform output).
Bash

    cd ansible
    ansible-playbook -i inventory/ec2_dynamic.yml playbooks/deploy_k8s_tools.yml --extra-vars "@../environments/dev/secrets.yml"

🧹 Cleanup

To tear down the entire infrastructure and avoid ongoing costs:

    Destroy Terraform Resources: This will remove the EKS cluster, EC2 instances, VPC, etc.
    Bash

    cd terraform
    terraform destroy -var-file=../environments/dev/terraform.tfvars

## Infrastructure Architecture
![MLOps Infrastructure](https://raw.githubusercontent.com/manupanand-freelance-developer/mlops-pipeline-prjt-20-2025/main/images/mlops.gif)


## Licence
MIT Licence