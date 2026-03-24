resource "aws_route_table" "rutas_publicas" { # Define a route table for public subnets
  vpc_id = aws_vpc.DEMO-VPC.id
  tags = {
    Name        = "Rutas-Publicas"
    Environment = "dev"
  }
}

resource "aws_route" "internet_access" { # Create a route to allow internet access for public subnets
  route_table_id         = aws_route_table.rutas_publicas.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id # Route traffic destined for the internet (0.0.0.0/0)
}

resource "aws_route_table_association" "public_subnet_association" { # Associate the public route table with the public subnets
  for_each       = local.public_subnets
  subnet_id      = aws_subnet.subnets[each.key].id
  route_table_id = aws_route_table.rutas_publicas.id # Associate the public route table with each public subnet
}
#########################################################################################################################################################################################

resource "aws_route_table" "rutas_privadas" { # Define a route table for private subnets
  vpc_id = aws_vpc.DEMO-VPC.id
  tags = {
    Name        = "Rutas-Privadas"
    Environment = "dev"
  }
}

resource "aws_route" "nat_access" { # Create a route to allow internet access for private subnets through the NAT gateway
  route_table_id         = aws_route_table.rutas_privadas.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id # Route traffic destined for the internet through the NAT gateway
}

resource "aws_route_table_association" "private_subnet_association" { # Associate the private route table with the private subnets
  for_each       = local.private_subnets
  subnet_id      = aws_subnet.subnets[each.key].id
  route_table_id = aws_route_table.rutas_privadas.id # Associate the private route table with each private subnet
}
