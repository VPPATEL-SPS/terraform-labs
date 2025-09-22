# terraform-labs

Repository contains example code for Terraform configurations demonstrating various AWS services and infrastructure patterns.

## Available Examples

### 🔧 AWS Systems Manager
**Directory**: `aws-systems-manager/`

Comprehensive examples for AWS Systems Manager (SSM) resources including:
- **Parameter Store**: Secure storage for configuration data and secrets
- **Documents**: Custom runbooks for automation tasks
- **Maintenance Windows**: Scheduled maintenance operations
- **Patch Management**: Automated OS patching and compliance
- **Logging & Monitoring**: S3-based logging for audit trails

**Key Features**:
- Production-ready configurations with security best practices
- Automated patch management and maintenance scheduling
- Secure parameter storage with encryption
- Cross-platform support (Linux/Windows)
- Comprehensive documentation and examples

[📖 View AWS Systems Manager Examples](./aws-systems-manager/README.md)

## Getting Started

1. **Choose an Example**: Navigate to the directory of the service you want to explore
2. **Review Documentation**: Each example includes detailed README with setup instructions
3. **Configure Variables**: Copy and customize the `.tfvars.example` file
4. **Deploy**: Run `terraform init`, `terraform plan`, and `terraform apply`

## Prerequisites

- [Terraform](https://terraform.io/downloads.html) >= 1.0
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- AWS IAM permissions for the services you want to deploy

## Best Practices

All examples in this repository follow Terraform and AWS best practices:
- ✅ Resource tagging for cost management and organization
- ✅ Security-first approach with least privilege access
- ✅ Comprehensive variable validation and documentation
- ✅ Output values for integration with other systems
- ✅ Example configurations for quick start

## Contributing

Contributions are welcome! Please:
1. Follow the existing code style and structure
2. Include comprehensive documentation
3. Add example variable files
4. Test your configurations before submitting
5. Update this main README with your new examples

## Support

For questions or issues:
- Check the individual example README files
- Review AWS and Terraform documentation
- Open an issue in this repository
