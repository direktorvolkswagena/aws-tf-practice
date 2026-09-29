variable "region" {
  description = "AWS region to deploy the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "Availability Zones to deploy VPC"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of CIDR blocks for public VPC subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of CIDR blocks for private VPC subnets"
  type        = list(string)
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}