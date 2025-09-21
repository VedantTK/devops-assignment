variable "project_name" {}
variable "environment" {}
variable "location" {}
variable "resource_group_name" {}
variable "tags" { type = map(string) }
variable "app_insights_key" {}
variable "subnet_id" {}
variable "storage_account_name" {}
variable "allowed_subnet_ids" {
  type        = list(string)
}