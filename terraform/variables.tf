
variable "aws_region" {
  description = "AWS region for the application infrastructure"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Name used to identify project resources"
  type        = string
  default     = "ai-ecommerce"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "Environment must be dev or prod."
  }

}
