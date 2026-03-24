locals { # Define local variables to categorize subnets into public and private based on the 'public' attribute in the input variable 'subnets'
  public_subnets = {
    for k, v in var.subnets : k => v if v.public # Filter the subnets to include only those marked as public 
  }

  private_subnets = {
    for k, v in var.subnets : k => v if !v.public # Filter the subnets to include only those not marked as public 
  }
}
