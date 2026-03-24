resource "aws_subnet" "subnets" {
  for_each = var.subnets

  vpc_id                  = aws_vpc.DEMO-VPC.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.public # Automatically assign public IPs to instances launched in this subnet if it's a public subnet

  tags = {
    Name        = each.key
    Environment = "dev"
  }

}
