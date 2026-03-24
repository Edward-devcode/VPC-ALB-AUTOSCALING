module "vpc" {
  source               = "../../MODULES/VPC"
  vpc_cidr_block       = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  subnets              = var.subnets
}

module "alb_autoscaling" {
  source                    = "../../MODULES/ALB_AUTOSCALING"
  vpc_id                    = module.vpc.vpc_id
  public_subnet             = module.vpc.public_subnet_ids
  private_subnet            = module.vpc.private_subnet_ids
  ami_id                    = var.ami_id
  instance_type             = var.instance_type
  key_name                  = var.key_name
  environment               = var.environment
  allowed_ssh_cidr          = var.allowed_ssh_cidr
  desired_capacity          = var.desired_capacity
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = var.health_check_grace_period
  instance_warmup           = var.instance_warmup
  deregistration_delay      = var.deregistration_delay
  cpu_target_value          = var.cpu_target_value

  depends_on = [module.vpc
  ]
}


