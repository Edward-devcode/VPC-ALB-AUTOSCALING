variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "enable_dns_hostnames" {
  description = "Whether to enable DNS hostnames in the VPC"
  type        = bool
}

variable "enable_dns_support" {
  description = "Whether to enable DNS support in the VPC"
  type        = bool
}

variable "subnets" {
  description = "A list of subnets to create in the VPC"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    public            = bool
  }))
}
