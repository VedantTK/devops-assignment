variable "project_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "location" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "tags" {
  type = map(string)
}
variable "subnet_id" {
  type = string
}

# New variables
variable "failover_location" {
  type        = string
}

variable "cosmos_max_ru" {
  type        = number
}

variable "partition_key_path" {
  type        = string
}
