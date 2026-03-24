resource "aws_eip" "ipnat" {
  domain = "vpc" # Allocate an Elastic IP address for use with the NAT gateway in a VPC
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.ipnat.id                                     # Use the allocated Elastic IP address for the NAT gateway
  subnet_id     = aws_subnet.subnets[keys(local.public_subnets)[0]].id # Place the NAT gateway in one of the public subnets (e.g., "Public-Subnet-1")
  tags = {
    Name        = "NAT-Gateway"
    Environment = "dev"
  }
}
