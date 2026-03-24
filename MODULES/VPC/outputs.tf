output "vpc_id" { # Output the ID of the VPC created by this module, which can be used by other modules or resources that need to reference the VPC
  value = aws_vpc.DEMO-VPC.id
}

output "subnet_ids" {
  value = {
    for k, v in aws_subnet.subnets : k => v.id # Output the IDs of all subnets created, using a for loop to iterate through the subnets and create a map of subnet names to their IDs
  }
}


output "public_subnet_ids" {
  value = [
    for v in aws_subnet.subnets : v.id if v.map_public_ip_on_launch # Output the IDs of the public subnets, filtering the subnets based on the local variable that identifies which subnets are public
  ]
}


output "private_subnet_ids" {
  value = [
    for v in aws_subnet.subnets : v.id if !v.map_public_ip_on_launch # Output the IDs of the private subnets, filtering the subnets based on the local variable that identifies which subnets are private
  ]
}
