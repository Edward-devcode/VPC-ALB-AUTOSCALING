resource "aws_autoscaling_group" "asg" {
  name                      = "Demo-ASG"
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  vpc_zone_identifier       = var.private_subnet
  health_check_type         = "ELB"
  health_check_grace_period = var.health_check_grace_period # Time in seconds to wait before checking the health status of an instance after it has been launched or has entered the InService state.
  default_instance_warmup   = var.instance_warmup           # Time in seconds that Auto Scaling waits for an instance to warm up before it starts checking the instance's health status.
  target_group_arns         = [aws_lb_target_group.tg.arn]
  launch_template {
    id      = aws_launch_template.asg.id
    version = "$Latest"
  }
}
