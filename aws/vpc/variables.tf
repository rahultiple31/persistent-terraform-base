variable "create_vpc" {
  description = "Whether to create the VPC."
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of the VPC."
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, stage, prod)."
  type        = string
}

variable "network_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "zones" {
  description = "List of availability zones."
  type        = list(string)
}

variable "instance_tenancy" {
  description = "Tenancy option for instances launched into the VPC."
  type        = string
  default     = "default"
}

variable "enable_dns_support" {
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  type        = bool
  default     = true
}

variable "vpc_tags" {
  type    = map(string)
  default = {}
}

variable "public_subnets_cidr" {
  type        = list(string)
  default     = []
}

variable "private_subnets_cidr" {
  type        = list(string)
  default     = []
}

variable "associate_public_ip" {
  type        = bool
  default     = false
}

variable "public_subnet_tags" {
  type    = map(string)
  default = {}
}

variable "private_subnet_tags" {
  type    = map(string)
  default = {}
}

variable "create_internet_gateway" {
  type        = bool
  default     = false
}

variable "enable_nat_gateway" {
  type        = bool
  default     = false
}

variable "tags" {
  type    = map(string)
  default = {}
}
