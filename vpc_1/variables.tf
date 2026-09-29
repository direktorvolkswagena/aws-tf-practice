variable "region" {
  description = "AWS region to deploy the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "Availability Zones to deploy VPC"
  type        = list(string)
}

variable "subnet_cidr_list" {
  description = "List of CIDR blocks for VPC subnets"
  type        = list(string)
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}