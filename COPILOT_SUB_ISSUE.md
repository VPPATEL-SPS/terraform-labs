# Sub-issue: Set up Terraform-specific Copilot Instructions

**Parent Issue:** [VPPATEL-SPS/github-action-labs#2](https://github.com/VPPATEL-SPS/github-action-labs/issues/2) - ✨ Set up Copilot instructions

## Issue Title
🏗️ Configure Terraform-specific Copilot instructions for terraform-labs repository

## Description

This sub-issue focuses on implementing Copilot instructions specifically tailored for Terraform development practices, extending the general Copilot setup from the parent issue to include Terraform-specific guidance.

## Objectives

### 1. Create `.copilot-instructions.md` file
Set up repository-specific instructions for GitHub Copilot to follow when working with Terraform code in this repository.

### 2. Terraform Best Practices Integration
Configure Copilot to understand and enforce:
- Terraform naming conventions
- Resource organization patterns
- State management best practices
- Security considerations for infrastructure code

### 3. Workflow Automation Guidelines
Include instructions for:
- Terraform plan/apply workflow automation
- Code review processes for infrastructure changes
- Testing strategies for Terraform modules
- Documentation generation for Terraform resources

## Acceptance Criteria

- [ ] Create `.copilot-instructions.md` file with Terraform-specific guidance
- [ ] Include Terraform coding standards and conventions
- [ ] Define infrastructure-as-code security best practices
- [ ] Add guidelines for Terraform module development
- [ ] Include examples of proper Terraform file organization
- [ ] Define testing approaches for Terraform code
- [ ] Add documentation requirements for Terraform resources
- [ ] Include CI/CD pipeline considerations for Terraform
- [ ] Reference parent issue for general Copilot setup context

## Terraform-Specific Guidelines to Include

### Code Organization
- Use consistent naming conventions for resources
- Organize code into logical modules
- Implement proper variable and output definitions
- Use appropriate data sources

### Security Practices
- Avoid hardcoded secrets in Terraform files
- Use secure parameter stores for sensitive values
- Implement least privilege access patterns
- Follow cloud provider security best practices

### Testing and Validation
- Include terraform validate in development workflow
- Use terraform plan for change review
- Implement automated testing for modules
- Document expected infrastructure outcomes

### Documentation
- Maintain clear README files for each module
- Document variable descriptions and types
- Include usage examples
- Keep changelog for infrastructure changes

## Implementation Tasks

1. **Research Terraform Best Practices**
   - Review industry standards for Terraform development
   - Analyze common patterns in terraform-labs use cases

2. **Create Copilot Instructions File**
   - Write comprehensive `.copilot-instructions.md`
   - Include specific Terraform guidance
   - Add code examples and patterns

3. **Validate Instructions**
   - Test Copilot behavior with new instructions
   - Ensure alignment with Terraform best practices
   - Verify usefulness for common development tasks

4. **Documentation Updates**
   - Update repository README with Copilot guidance
   - Add links to relevant Terraform documentation
   - Include troubleshooting tips

## Success Metrics

- Copilot provides relevant Terraform suggestions
- Code suggestions follow established conventions
- Infrastructure code maintains security standards
- Development workflow efficiency improves
- Documentation quality increases

## Related Resources

- [Terraform Best Practices Guide](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)
- [GitHub Copilot for Infrastructure](https://docs.github.com/en/copilot)
- [Terraform Style Guide](https://www.terraform.io/docs/language/syntax/style.html)
- Parent Issue: [github-action-labs#2](https://github.com/VPPATEL-SPS/github-action-labs/issues/2)

## Labels
- `enhancement`
- `terraform`
- `copilot`
- `documentation`
- `sub-issue`

## Assignee
@Copilot

---

*This sub-issue is part of the broader initiative to set up Copilot instructions across repositories. It specifically addresses the unique needs of Terraform development workflows.*