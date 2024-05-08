variable "env_name"{
    description = "define the environment details"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
}

variable "location" {
  description = "The Azure region where the resources should be created."
  default     = "East US"
}

variable "app_service_name" {
  description = "The name of the Azure App Service."
}

variable "app_service_plan_name" {
  description = "The name of the Azure App Service Plan."
}

variable "vnet_name" {
  description = "The name of the Virtual Network (VNet) in which to deploy the App Service."
}

variable "subnet_name" {
  description = "The name of the subnet within the VNet."
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet."
  default  = "10.0.0.0/24"
}

