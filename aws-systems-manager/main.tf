# AWS Systems Manager Resources Example
# This configuration demonstrates various AWS Systems Manager resources

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

# Data source to get current AWS account ID and region
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# SSM Parameter Store - String Parameter
resource "aws_ssm_parameter" "app_config_string" {
  name  = "/myapp/config/environment"
  type  = "String"
  value = var.app_environment
  description = "Application environment configuration"

  tags = var.common_tags
}

# SSM Parameter Store - SecureString Parameter
resource "aws_ssm_parameter" "database_password" {
  name  = "/myapp/database/password"
  type  = "SecureString"
  value = var.database_password
  description = "Database password stored securely"

  tags = var.common_tags
}

# SSM Parameter Store - StringList Parameter
resource "aws_ssm_parameter" "allowed_ips" {
  name  = "/myapp/security/allowed_ips"
  type  = "StringList"
  value = join(",", var.allowed_ip_addresses)
  description = "List of allowed IP addresses"

  tags = var.common_tags
}

# SSM Document for running shell commands
resource "aws_ssm_document" "shell_script_document" {
  name          = "CustomShellScript"
  document_type = "Command"
  document_format = "YAML"

  content = <<DOC
schemaVersion: '2.2'
description: 'Run a custom shell script on EC2 instances'
parameters:
  scriptContent:
    type: String
    description: 'Shell script content to execute'
    default: 'echo "Hello from SSM!"'
mainSteps:
  - action: 'aws:runShellScript'
    name: 'runShellScript'
    inputs:
      runCommand:
        - '{{ scriptContent }}'
DOC

  tags = var.common_tags
}

# SSM Document for PowerShell commands (Windows)
resource "aws_ssm_document" "powershell_document" {
  name          = "CustomPowerShellScript"
  document_type = "Command"
  document_format = "YAML"

  content = <<DOC
schemaVersion: '2.2'
description: 'Run a custom PowerShell script on Windows instances'
parameters:
  scriptContent:
    type: String
    description: 'PowerShell script content to execute'
    default: 'Write-Host "Hello from SSM PowerShell!"'
mainSteps:
  - action: 'aws:runPowerShellScript'
    name: 'runPowerShellScript'
    inputs:
      runCommand:
        - '{{ scriptContent }}'
DOC

  tags = var.common_tags
}

# SSM Maintenance Window
resource "aws_ssm_maintenance_window" "maintenance_window" {
  name     = "maintenance-window-${var.app_environment}"
  description = "Maintenance window for ${var.app_environment} environment"
  duration = 3
  cutoff   = 1
  schedule = "cron(0 16 ? * TUE *)"  # Every Tuesday at 4 PM UTC
  schedule_timezone = "UTC"

  tags = var.common_tags
}

# SSM Maintenance Window Target
resource "aws_ssm_maintenance_window_target" "maintenance_target" {
  window_id     = aws_ssm_maintenance_window.maintenance_window.id
  name          = "maintenance-target-${var.app_environment}"
  description   = "Maintenance window target for instances"
  resource_type = "INSTANCE"

  targets {
    key    = "tag:Environment"
    values = [var.app_environment]
  }

  targets {
    key    = "tag:MaintenanceWindow"
    values = ["enabled"]
  }
}

# SSM Maintenance Window Task
resource "aws_ssm_maintenance_window_task" "update_ssm_agent" {
  window_id        = aws_ssm_maintenance_window.maintenance_window.id
  name             = "update-ssm-agent"
  description      = "Update SSM Agent on target instances"
  task_type        = "RUN_COMMAND"
  task_arn         = "AWS-UpdateSSMAgent"
  priority         = 1
  service_role_arn = aws_iam_role.ssm_maintenance_role.arn
  max_concurrency  = "2"
  max_errors       = "1"

  targets {
    key    = "WindowTargetIds"
    values = [aws_ssm_maintenance_window_target.maintenance_target.id]
  }

  task_invocation_parameters {
    run_command_parameters {
      output_s3_bucket     = aws_s3_bucket.ssm_logs.id
      output_s3_key_prefix = "maintenance-window-logs/"
      service_role_arn     = aws_iam_role.ssm_maintenance_role.arn
      timeout_seconds      = 3600
    }
  }
}

# S3 Bucket for SSM logs
resource "aws_s3_bucket" "ssm_logs" {
  bucket = "ssm-logs-${var.app_environment}-${random_string.bucket_suffix.result}"

  tags = var.common_tags
}

resource "aws_s3_bucket_versioning" "ssm_logs_versioning" {
  bucket = aws_s3_bucket.ssm_logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "ssm_logs_encryption" {
  bucket = aws_s3_bucket.ssm_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Random string for unique bucket naming
resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

# IAM Role for SSM Maintenance Window
resource "aws_iam_role" "ssm_maintenance_role" {
  name = "SSMMaintenanceWindowRole-${var.app_environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ssm.amazonaws.com"
        }
      }
    ]
  })

  tags = var.common_tags
}

# IAM Role Policy for SSM Maintenance Window
resource "aws_iam_role_policy" "ssm_maintenance_policy" {
  name = "SSMMaintenanceWindowPolicy-${var.app_environment}"
  role = aws_iam_role.ssm_maintenance_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:SendCommand",
          "ssm:ListCommands",
          "ssm:ListCommandInvocations",
          "ssm:DescribeInstanceInformation",
          "ssm:GetCommandInvocation",
          "ssm:DescribeInstanceAssociationsStatus",
          "ssm:DescribeEffectiveInstanceAssociations"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject"
        ]
        Resource = "${aws_s3_bucket.ssm_logs.arn}/*"
      }
    ]
  })
}

# SSM Patch Group
resource "aws_ssm_patch_group" "patch_group" {
  baseline_id = aws_ssm_patch_baseline.patch_baseline.id
  patch_group = "patch-group-${var.app_environment}"
}

# SSM Patch Baseline for Amazon Linux
resource "aws_ssm_patch_baseline" "patch_baseline" {
  name             = "patch-baseline-${var.app_environment}"
  description      = "Patch baseline for ${var.app_environment} environment"
  operating_system = "AMAZON_LINUX_2"

  approval_rule {
    approve_after_days  = 7
    compliance_level    = "HIGH"
    enable_non_security = true

    patch_filter {
      key    = "PRODUCT"
      values = ["AmazonLinux2"]
    }

    patch_filter {
      key    = "CLASSIFICATION"
      values = ["Security", "Bugfix", "Critical", "Important"]
    }

    patch_filter {
      key    = "SEVERITY"
      values = ["Critical", "Important"]
    }
  }

  tags = var.common_tags
}

# SSM Association for patch baseline
resource "aws_ssm_association" "patch_association" {
  name = "AWS-RunPatchBaseline"

  targets {
    key    = "tag:PatchGroup"
    values = ["patch-group-${var.app_environment}"]
  }

  schedule_expression = "cron(0 02 ? * SUN *)"  # Every Sunday at 2 AM UTC

  parameters = {
    Operation = "Install"
  }

  output_location {
    s3_bucket_name = aws_s3_bucket.ssm_logs.id
    s3_key_prefix  = "patch-logs/"
  }
}