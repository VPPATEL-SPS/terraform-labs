# Variables for AWS Systems Manager resources

variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "app_environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = can(regex("^(dev|staging|prod)$", var.app_environment))
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "database_password" {
  description = "Database password to store in SSM Parameter Store"
  type        = string
  sensitive   = true
  default     = "ChangeMe123!"
}

variable "allowed_ip_addresses" {
  description = "List of allowed IP addresses"
  type        = list(string)
  default     = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Project     = "terraform-labs"
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}

variable "maintenance_window_schedule" {
  description = "Cron expression for maintenance window schedule"
  type        = string
  default     = "cron(0 16 ? * TUE *)"  # Every Tuesday at 4 PM UTC
}

variable "patch_schedule" {
  description = "Cron expression for patch schedule"
  type        = string
  default     = "cron(0 02 ? * SUN *)"  # Every Sunday at 2 AM UTC
}

variable "max_concurrency" {
  description = "Maximum number of instances to run maintenance tasks on concurrently"
  type        = string
  default     = "2"
}

variable "max_errors" {
  description = "Maximum number of errors allowed before stopping maintenance tasks"
  type        = string
  default     = "1"
}