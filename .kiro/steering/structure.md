# Project Structure

## File Organization

### Core Terraform Files
- `provider.tf` - Provider configuration and version constraints
- `variables.tf` - Input variable definitions
- `droplets.tf` - DigitalOcean droplet resource definitions
- `firewall.tf` - Security group and firewall rules
- `data.tf` - Data sources (SSH keys, current IP)
- `outputs.tf` - Output values and local file generation
- `terraform.tfvars` - Variable values (contains sensitive data)

### State and Lock Files
- `terraform.tfstate` - Current infrastructure state
- `terraform.tfstate.backup` - Previous state backup
- `.terraform.lock.hcl` - Provider version locks

### Templates
- `templates/inventory.yml.tpl` - Ansible inventory template

### Generated Files
- Ansible inventory is generated at `../../ansible/infra-ansible-home-digitalocean/inventory.yml`

## Naming Conventions

### Resources
- Droplets: `do-server-{number}` format
- Firewalls: Descriptive names like `ssh-only-firewall`
- SSH keys: Reference existing keys by name (`id_clouds_fs`)

### Variables
- Snake case for variable names (`do_token`, `pvt_key`)
- Descriptive names that indicate purpose

### Outputs
- Snake case with descriptive names
- Include both raw values and formatted commands for user convenience

## Architecture Patterns

### Security First
- Firewall rules are restrictive by default
- SSH access limited to current IP address
- Outbound traffic allowed for system updates

### Template Integration
- Uses templatefile() function for dynamic content generation
- Separates templates in dedicated directory
- Generates external configuration files for other tools (Ansible)

### Data Sources
- Leverages external data sources for dynamic configuration
- Automatically detects current IP for firewall rules
- References existing cloud resources by name