output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.lb.dns_name
}

output "asg_name" {
  description = "The name of the Auto Scaling Group"
  value       = aws_autoscaling_group.asg.name
}

