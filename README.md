# DevOps Assignment: Azure Infrastructure

## Overview
This repository contains the Terraform-based infrastructure for a scalable classroom application with Azure PaaS services.

## Directory Structure
terraform/
├─ modules/
│ ├─ networking/
│ ├─ keyvault/
│ ├─ cosmosdb/
│ ├─ appinsights/
│ ├─ function_app/
│ └─ rbac/
├─ main.tf
├─ variables.tf
├─ outputs.tf
└─ terraform.tfvars
docs/
├─ architecture.md
└─ compliance.md
.github/workflows/
└─ terraform.yml


## Prerequisites
- Terraform v1.5+
- Azure CLI logged in
- GitHub repository for CI/CD

## Setup Instructions

    1. Initialize Terraform
    cd terraform
    terraform init

    2. Plan Terraform
    terraform plan

    3. Apply Terraform
    terraform apply

    4. Destroy Resources (optional)
    terraform destroy
