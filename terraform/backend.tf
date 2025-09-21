############################################
# backend.tf
# Remote backend for Terraform state
# (use Azure Storage Account for team collaboration & security)
############################################

# terraform {
#   backend "azurerm" {
#     resource_group_name  = var.backend_resource_group
#     storage_account_name = var.backend_storage_account
#     container_name       = var.backend_container_name
#     key                  = var.backend_key
#   }
# }
