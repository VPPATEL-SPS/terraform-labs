# AWS Systems Manager Terraform Examples

This directory contains Terraform configurations that demonstrate how to create and manage various AWS Systems Manager (SSM) resources. These examples provide a comprehensive foundation for managing infrastructure using AWS Systems Manager services.

## Resources Created

This Terraform configuration creates the following AWS Systems Manager resources:

### 1. SSM Parameter Store
- **String Parameter**: Application environment configuration
- **SecureString Parameter**: Database password stored securely with encryption
- **StringList Parameter**: List of allowed IP addresses

### 2. SSM Documents
- **Shell Script Document**: Custom document for running shell commands on Linux instances
- **PowerShell Document**: Custom document for running PowerShell commands on Windows instances

### 3. SSM Maintenance Windows
- **Maintenance Window**: Scheduled maintenance window for system updates
- **Maintenance Window Target**: Targets EC2 instances based on tags
- **Maintenance Window Task**: Automated task to update SSM Agent

### 4. SSM Patch Management
- **Patch Baseline**: Custom patch baseline for Amazon Linux 2
- **Patch Group**: Group of instances for patch management
- **Patch Association**: Automated patching schedule

### 5. Supporting Resources
- **S3 Bucket**: Storage for SSM logs and command outputs
- **IAM Role**: Service role for SSM maintenance window operations
- **IAM Policy**: Permissions for SSM operations

## Prerequisites

Before using this Terraform configuration, ensure you have:

1. **AWS CLI configured** with appropriate credentials
2. **Terraform installed** (version >= 1.0)
3. **AWS IAM permissions** for:
   - SSM Parameter Store operations
   - SSM Document management
   - SSM Maintenance Window operations
   - SSM Patch management
   - S3 bucket operations
   - IAM role and policy management

## Usage

### 1. Clone and Navigate
```bash
git clone <repository-url>
cd terraform-labs/aws-systems-manager
```

### 2. Configure Variables
Copy the example variables file and customize it:
```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` with your specific values:
```hcl
aws_region = "us-west-2"
app_environment = "production"
database_password = "your-secure-password"
# ... other variables
```

### 3. Initialize Terraform
```bash
terraform init
```

### 4. Plan the Deployment
```bash
terraform plan
```

### 5. Apply the Configuration
```bash
terraform apply
```

### 6. View Outputs
```bash
terraform output
```

## Configuration Files

- **`main.tf`**: Main Terraform configuration with all resources
- **`variables.tf`**: Variable definitions with descriptions and validation
- **`outputs.tf`**: Output values for created resources
- **`terraform.tfvars.example`**: Example variable values

## Key Features

### Parameter Store Security
- Secure storage of sensitive data using SecureString parameters
- Automatic encryption using AWS KMS
- Proper tagging for resource management

### Automated Maintenance
- Scheduled maintenance windows for system updates
- Configurable concurrency and error handling
- S3 logging for audit trails

### Patch Management
- Automated patch baseline for security updates
- Flexible patch scheduling
- Compliance tracking and reporting

### Document Management
- Custom SSM documents for common tasks
- Support for both Linux (shell) and Windows (PowerShell)
- Parameterized execution for flexibility

## Best Practices Implemented

1. **Security**
   - Sensitive data stored in SecureString parameters
   - IAM roles with least privilege access
   - S3 bucket encryption enabled

2. **Monitoring and Logging**
   - S3 bucket for storing command outputs
   - Versioning enabled on S3 bucket
   - Comprehensive output values for monitoring

3. **Flexibility**
   - Configurable schedules for maintenance and patching
   - Environment-specific resource naming
   - Customizable tags for resource management

4. **Compliance**
   - Automated patch management
   - Audit trails through S3 logging
   - Proper resource tagging

## Example Use Cases

### 1. Parameter Store for Configuration Management
```bash
# Retrieve application configuration
aws ssm get-parameter --name "/myapp/config/environment" --region us-east-1

# Retrieve secure database password
aws ssm get-parameter --name "/myapp/database/password" --with-decryption --region us-east-1
```

### 2. Running Commands via SSM Documents
```bash
# Execute shell script on tagged instances
aws ssm send-command \
  --document-name "CustomShellScript" \
  --parameters 'scriptContent=["echo Hello World; whoami"]' \
  --targets "Key=tag:Environment,Values=dev"
```

### 3. Maintenance Window Management
The maintenance window automatically runs every Tuesday at 4 PM UTC to update the SSM Agent on all targeted instances.

### 4. Patch Management
Automated patching occurs every Sunday at 2 AM UTC for instances in the designated patch group.

## Customization

### Adding New Parameters
To add new SSM parameters, add resources like this to `main.tf`:
```hcl
resource "aws_ssm_parameter" "new_parameter" {
  name  = "/myapp/config/new_setting"
  type  = "String"
  value = var.new_setting_value
  description = "Description of the new setting"
  tags = var.common_tags
}
```

### Modifying Schedules
Update the cron expressions in `variables.tf` or your `terraform.tfvars` file:
```hcl
maintenance_window_schedule = "cron(0 20 ? * FRI *)"  # Friday 8 PM UTC
patch_schedule = "cron(0 03 ? * SAT *)"              # Saturday 3 AM UTC
```

### Adding Instance Targets
Tag your EC2 instances appropriately to include them in maintenance operations:
```bash
# For maintenance window targeting
aws ec2 create-tags --resources i-1234567890abcdef0 --tags Key=Environment,Value=dev

# For patch group targeting
aws ec2 create-tags --resources i-1234567890abcdef0 --tags Key=PatchGroup,Value=patch-group-dev
```

## Cleanup

To destroy all created resources:
```bash
terraform destroy
```

## Support and Documentation

- [AWS Systems Manager Documentation](https://docs.aws.amazon.com/systems-manager/)
- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS Systems Manager Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-parameter-store.html)
- [AWS Systems Manager Maintenance Windows](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-maintenance.html)
- [AWS Systems Manager Patch Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-patch.html)

## Contributing

When contributing to this example:
1. Follow Terraform best practices
2. Update documentation for any new resources
3. Include appropriate variable validation
4. Add corresponding outputs for new resources
5. Test configurations in a development environment first