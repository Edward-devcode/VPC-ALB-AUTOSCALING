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

variable "key_name" {
  description = "The name of the key pair to use for SSH access to the instances."
  type        = string
}

variable "environment" {
  description = "The environment for the resources (e.g., dev, staging, prod)."
  type        = string
}

variable "ami_id" {
  description = "The ID of the Amazon Machine Image (AMI) to use for the Auto Scaling Group instances."
  type        = string
}

variable "instance_type" {
  description = "The instance type to use for the Auto Scaling Group instances."
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "The CIDR block that is allowed to access the instances via SSH."
  type        = string
}


variable "desired_capacity" {
  description = "The desired number of instances in the Auto Scaling Group."
  type        = number
}

variable "max_size" {
  description = "The maximum number of instances in the Auto Scaling Group."
  type        = number
}

variable "min_size" {
  description = "The minimum number of instances in the Auto Scaling Group."
  type        = number
}

variable "cpu_target_value" {
  description = "The target value for CPU utilization to trigger scaling actions."
  type        = number
}

variable "instance_warmup" {
  description = "The amount of time, in seconds, that Auto Scaling waits for an instance to warm up before it starts checking the instance's health status."
  type        = number
}

variable "health_check_grace_period" {
  description = "The amount of time, in seconds, that Auto Scaling waits before checking the health status of an instance after it has been launched or has entered the InService state."
  type        = number
}

variable "deregistration_delay" {
  description = "The amount of time, in seconds, that the load balancer waits before deregistering an instance from the target group after it has been marked for termination."
  type        = number
}

