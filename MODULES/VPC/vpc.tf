resource "aws_vpc" "DEMO-VPC" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames # Enable DNS hostnames in the VPC
  enable_dns_support   = var.enable_dns_support   # Enable DNS support in the VPC
  tags = {
    Name        = "DEMO-VPC"
    Environment = "dev"
  }
}
