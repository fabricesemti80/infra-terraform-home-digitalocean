# Technology Stack

## Infrastructure as Code
- **Terraform/OpenTofu**: Primary IaC tool for provisioning infrastructure
- **Provider**: DigitalOcean provider (~> 2.0)
- **Additional Providers**: HTTP provider for IP detection, Local provider for file generation

## Cloud Platform
- **DigitalOcean**: Cloud provider for droplet hosting
- **Region**: NYC2 (New York)
- **OS**: Ubuntu 22.04 LTS

## Configuration Management
- **Ansible**: Integration via generated inventory file
- **Templates**: Jinja2-style templating for dynamic configuration

## Common Commands

### Terraform Operations
```bash
# Initialize Terraform
terraform init

# Plan infrastructure changes
terraform plan

# Apply infrastructure changes
terraform apply

# Destroy infrastructure
terraform destroy

# Format Terraform files
terraform fmt

# Validate configuration
terraform validate
```

### State Management
```bash
# Show current state
terraform show

# List resources in state
terraform state list

# Refresh state
terraform refresh
```

## Security Considerations
- API tokens should be managed via environment variables or secure vaults
- SSH keys are referenced by name from DigitalOcean account
- Firewall automatically restricts access to current public IP