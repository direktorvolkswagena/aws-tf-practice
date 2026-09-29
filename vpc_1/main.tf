# Fully built with AWS official module

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc_1"
  cidr = var.vpc_cidr

  azs             = var.azs
  private_subnets = var.subnet_cidr_list

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}