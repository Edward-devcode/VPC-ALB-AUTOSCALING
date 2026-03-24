resource "aws_internet_gateway" "igw" { # Create an Internet Gateway to allow communication between the VPC and the internet
  vpc_id = aws_vpc.DEMO-VPC.id
  tags = {
    Name        = "DEMO-IGW"
    Environment = "dev"
  }

}
