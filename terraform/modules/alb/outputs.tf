output "alb_dns_name" {
  description = "Public DNS name of the ALB"
  value       = aws_lb.app.dns_name
}

output "target_group_arn" {
  description = "Target group ARN for ECS"
  value       = aws_lb_target_group.app.arn
}

output "alb_arn" {
  description = "Application Load Balancer ARN"
  value       = aws_lb.app.arn
}
