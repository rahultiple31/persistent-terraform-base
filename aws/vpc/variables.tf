variable "create_vpc" {
  description = "Whether to create the VPC or not."
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
  description = "List of availability zones to use."
  type        = list(string)
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC."
  type        = string
  default     = "default"
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC."
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC."
  type        = bool
  default     = true
}

variable "vpc_tags" {
  description = "Additional tags for the VPC."
  type        = map(string)
  default     = {}
}

variable "public_subnets_cidr" {
  description = "List of public subnet CIDR blocks."
  type        = list(string)
  default     = []
}

variable "private_subnets_cidr" {
  description = "List of private subnet CIDR blocks."
  type        = list(string)
  default     = []
}

variable "associate_public_ip" {
  description = "Associate public IPs with private subnets (usually false)."
  type        = bool
  default     = false
}

variable "public_subnet_tags" {
  description = "Additional tags for public subnets."
  type        = map(string)
  default     = {}
}

variable "private_subnet_tags" {
  description = "Additional tags for private subnets."
  type        = map(string)
  default     = {}
}

variable "private_route_table_tags" {
  description = "Additional tags for private route tables."
  type        = map(string)
  default     = {}
}

variable "create_internet_gateway" {
  description = "Whether to create an Internet Gateway."
  type        = bool
  default     = false
}

variable "enable_nat_gateway" {
  description = "Whether to enable NAT Gateway creation."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}
