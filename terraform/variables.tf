# Project Name (prefix for resource naming)
variable "project_name" {
  type        = string
  description = "Project name prefix for all resources"
}

# Environment (dev/staging/prod)
variable "environment" {
  type        = string
  description = "Deployment environment"
}

# Azure Region
variable "location" {
  type        = string
  description = "Azure region to deploy resources"
  default     = "East US"
}

# Tags applied to all resources
variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}

# Azure AD Object IDs for RBAC
variable "admin_object_id" {
  type        = string
  description = "Azure AD Object ID of Admin user or service principal"
}

variable "dev_object_id" {
  type        = string
  description = "Azure AD Object ID of Developer user or service principal"
}

# Optional: storage account name for Function App (must be globally unique)
variable "storage_account_name" {
  type        = string
  description = "Storage account name for Function App (optional)"
}

# List of subnet IDs allowed to access the storage account (VNet integration)
variable "allowed_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs allowed to access the storage account"
}

# Cosmos DB Scaling Variables
variable "cosmos_max_ru" {
  type        = number
  description = "Maximum autoscale RU/s for Cosmos DB"
  default     = 20000
}

variable "partition_key_path" {
  type        = string
  description = "Partition key path for Cosmos DB container"
  default     = "/studentId"
}

variable "failover_location" {
  type        = string
  description = "Secondary region for Cosmos DB failover"
  default     = "West US"
}
