# Output values for AWS Systems Manager resources

output "ssm_parameter_string_name" {
  description = "Name of the SSM parameter for app environment"
  value       = aws_ssm_parameter.app_config_string.name
}

output "ssm_parameter_string_arn" {
  description = "ARN of the SSM parameter for app environment"
  value       = aws_ssm_parameter.app_config_string.arn
}

output "ssm_parameter_securestring_name" {
  description = "Name of the SSM parameter for database password"
  value       = aws_ssm_parameter.database_password.name
}

output "ssm_parameter_securestring_arn" {
  description = "ARN of the SSM parameter for database password"
  value       = aws_ssm_parameter.database_password.arn
}

output "ssm_parameter_stringlist_name" {
  description = "Name of the SSM parameter for allowed IPs"
  value       = aws_ssm_parameter.allowed_ips.name
}

output "ssm_document_shell_name" {
  description = "Name of the SSM document for shell scripts"
  value       = aws_ssm_document.shell_script_document.name
}

output "ssm_document_shell_arn" {
  description = "ARN of the SSM document for shell scripts"
  value       = aws_ssm_document.shell_script_document.arn
}

output "ssm_document_powershell_name" {
  description = "Name of the SSM document for PowerShell scripts"
  value       = aws_ssm_document.powershell_document.name
}

output "ssm_document_powershell_arn" {
  description = "ARN of the SSM document for PowerShell scripts"
  value       = aws_ssm_document.powershell_document.arn
}

output "ssm_maintenance_window_id" {
  description = "ID of the SSM maintenance window"
  value       = aws_ssm_maintenance_window.maintenance_window.id
}

output "ssm_maintenance_window_arn" {
  description = "ARN of the SSM maintenance window"
  value       = aws_ssm_maintenance_window.maintenance_window.arn
}

output "ssm_patch_baseline_id" {
  description = "ID of the SSM patch baseline"
  value       = aws_ssm_patch_baseline.patch_baseline.id
}

output "ssm_patch_baseline_arn" {
  description = "ARN of the SSM patch baseline"
  value       = aws_ssm_patch_baseline.patch_baseline.arn
}

output "ssm_patch_group_id" {
  description = "ID of the SSM patch group"
  value       = aws_ssm_patch_group.patch_group.id
}

output "s3_logs_bucket_name" {
  description = "Name of the S3 bucket for SSM logs"
  value       = aws_s3_bucket.ssm_logs.id
}

output "s3_logs_bucket_arn" {
  description = "ARN of the S3 bucket for SSM logs"
  value       = aws_s3_bucket.ssm_logs.arn
}

output "iam_role_arn" {
  description = "ARN of the IAM role for SSM maintenance window"
  value       = aws_iam_role.ssm_maintenance_role.arn
}

output "region" {
  description = "AWS region where resources are created"
  value       = data.aws_region.current.name
}

output "account_id" {
  description = "AWS account ID where resources are created"
  value       = data.aws_caller_identity.current.account_id
}