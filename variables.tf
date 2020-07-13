variable "ibmcloud_api_key" {
  description = "<You IAM based API key.>"
}

variable "vpc_region" {
  description = "The VPC region to deploy the resources under."
}

variable "resource_group" {
  description = "The resource group for all the resources created (VPC and non VPC)."
  default     = "default"
}

variable "resources_prefix" {
  description = "Prefix is added to all resources that are created by this template."
  default     = "byok"
}

variable "generation" {
  description = "The VPC generation, currently supports Gen 1. Gen 2 tested in Beta."
  default     = 1
}

variable "null" {
  default = ""
}
