
variable "project_name" {
  description = "Project name used in resource tags"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
}

variable "allowed_http_cidr" {
  description = "CIDR allowed to access HTTP"
  type        = string
  default     = "0.0.0.0/0"
}
