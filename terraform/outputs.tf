
output "aws_region" {
  description = "AWS region selected for deployment"
  value       = var.aws_region
}

output "project_name" {
  description = "Project name"
  value       = var.project_name
}

output "environment" {
  description = "Selected deployment environment"
  value       = var.environment
}
