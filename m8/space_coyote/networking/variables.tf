variable "prefix" {
  type        = string
  description = "(Required) This prefix will be included in the name of most resources."
}

variable "environment" {
  type        = string
  description = "(Required) Application environment for deployment, defaults to development."
}

variable "region" {
  type        = string
  description = "(Optional) The region where the resources are created. Defaults to us-east-1."
  default     = "us-east-1"
}

variable "address_space" {
  type        = string
  description = "(Required) The address space that is used by the virtual network. You can supply more than one address space. Changing this forces a new resource to be created. Example: 10.0.0.0/16."
}

variable "subnet_prefix" {
  type        = string
  description = "(Required) The address prefix to use for the subnet. Example: 10.0.10.0/24."
  default     = "10.0.10.0/24"
}