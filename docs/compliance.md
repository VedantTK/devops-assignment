# Security & Compliance

## Secret Management
- All secrets are stored in **Azure Key Vault**.  
- Secrets are referenced in Terraform modules via variables or Azure AD RBAC.  

## Network Security
- Private Endpoints are used for Cosmos DB and Key Vault to eliminate public exposure.  
- Function Apps use **VNet integration** to communicate securely with backend services.  

## DDoS & Monitoring
- Azure automatically protects PaaS services using built-in DDoS protection.  
- Application Insights provides audit logging and monitoring.

## Data Retention & Backups
- Cosmos DB configured with **multi-region failover** for disaster recovery.  
- Key Vault and Cosmos DB soft-delete enabled for accidental deletion protection.  

## Compliance
- **FERPA:** Sensitive student data resides in private Cosmos DB endpoints; access controlled via RBAC.  
- **GDPR:** Only authorized users have access; all secrets and sensitive data encrypted at rest and in transit.  
- **Audit logging:** Application Insights + Azure Activity Logs capture changes and access.
