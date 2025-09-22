# Basic EC2 Instance Example

This example demonstrates creating a basic EC2 instance following the Copilot instructions for this repository.

## Files

- `main.tf` - Main resource definitions
- `variables.tf` - Input variables
- `outputs.tf` - Output values
- `versions.tf` - Provider requirements

## Usage

1. Copy `terraform.tfvars.example` to `terraform.tfvars`
2. Update variable values as needed
3. Run `terraform init`
4. Run `terraform plan`
5. Run `terraform apply`

## Cleanup

Run `terraform destroy` to remove all created resources.

## Cost Note

This example creates billable AWS resources. Remember to destroy them when done.