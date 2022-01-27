variable "prefix" {
  type        = string
  description = "(Required) This prefix will be included in the name of most resources."
}

variable "project" {
  type        = string
  description = "(Required) Application project name."
}

variable "environment" {
  type        = string
  description = "(Optional) Application environment for deployment, defaults to development."
  default     = "development"
}

variable "region" {
  type        = string
  description = "(Optional) The region where the resources are created. Defaults to us-east-1."
  default     = "us-east-1"
}

variable "address_space" {
  type        = string
  description = "(Optional) The address space that is used by the virtual network. You can supply more than one address space. Changing this forces a new resource to be created. Defaults to 10.0.0.0/16."
  default     = "10.0.0.0/16"
}

variable "subnet_prefix" {
  type        = string
  description = "(Optional) The address prefix to use for the subnet. Defaults to 10.0.10.0/24."
  default     = "10.0.10.0/24"
}

variable "instance_type" {
  type        = string
  description = "(Optional) Specifies the AWS instance type. Defaults to t2.micro."
  default     = "t2.micro"
}

variable "height" {
  type        = string
  default     = "400"
  description = "(Optional) Image height in pixels. Defaults to 400"
}

variable "width" {
  type        = string
  default     = "600"
  description = "(Optional) Image width in pixels. Defaults to 600"
}

variable "placeholder" {
  type        = string
  default     = "placedog.net"
  description = "(Optional) Diamond Dog URL. Defaults to placedog.net."
}
