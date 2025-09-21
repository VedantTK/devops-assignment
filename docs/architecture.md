# Azure Infrastructure Architecture

## Overview
This infrastructure is designed to support a **scalable classroom application** that can grow from ~50 users to 25,000+ concurrent students. It uses **Azure PaaS services**, private networking, and IaC practices.

## Components

### Networking
- **VNet:** 10.0.0.0/16  
- **Subnets:**  
  - `subnet-functions` → Function Apps (VNet-integrated)  
  - `subnet-data` → Cosmos DB and Key Vault Private Endpoints  
  - `subnet-shared` → Future workloads (AKS, Bastion)  

### Compute
- **Azure Functions (Linux)**  
  - Python runtime 3.9  
  - VNet Integration for secure access to private services  

### Data
- **Cosmos DB (Global DocumentDB)**  
  - Multi-region replication: Primary region + failover  
  - Private Endpoint for secure connectivity  

### Secrets & Security
- **Key Vault** for storing secrets (Cosmos DB connection, API keys)  
- **RBAC** for least privilege access:
  - Admin → Owner  
  - Developer → Contributor  

### Observability
- **Application Insights** for monitoring Function Apps, including request rates, failures, performance  

### Scalability & Cost Optimization
- **Function Apps** → Serverless, auto-scale based on load  
- **Cosmos DB** → Multi-region replication with failover priority  
- **Cost control:** Retention policies, tags for cost tracking, storage tier optimization
