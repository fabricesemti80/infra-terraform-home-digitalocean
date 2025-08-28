# Templates Documentation

## Overview
The `templates/` directory contains Jinja2-style template files used by Terraform to generate dynamic configuration files for external tools.

## Template Files

### inventory.yml.tpl
**Purpose**: Generates Ansible inventory file for configuration management

**Location**: `templates/inventory.yml.tpl`

**Generated Output**: `../../ansible/infra-ansible-home-digitalocean/inventory.yml`

**Template Variables**:
- `droplet_ip`: The public IP address of the provisioned droplet
- `ssh_key_path`: Path to the private SSH key file

**Structure**:
```yaml
---
all:
  children:
    digitalocean:
      hosts:
        do-server-1:
          ansible_host: ${droplet_ip}
          ansible_user: root
          ansible_ssh_private_key_file: ${ssh_key_path}
          ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
      vars:
        ansible_python_interpreter: /usr/bin/python3
```

**Key Features**:
- Automatically configures Ansible to connect to the droplet
- Uses root user for initial configuration
- Disables SSH host key checking for automated deployment
- Specifies Python 3 interpreter for Ansible modules

## Template Usage in Terraform

Templates are processed using Terraform's `templatefile()` function:

```hcl
resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.yml.tpl", {
    droplet_ip = digitalocean_droplet.do-server-1.ipv4_address
    ssh_key_path = var.pvt_key
  })
  filename = "../../ansible/infra-ansible-home-digitalocean/inventory.yml"
}
```

## Best Practices

### Template Organization
- Keep templates in dedicated `templates/` directory
- Use descriptive filenames with `.tpl` extension
- Group related templates by tool or purpose

### Variable Naming
- Use snake_case for template variables
- Choose descriptive names that indicate data source
- Document all template variables in comments

### Output Management
- Generate files outside the Terraform working directory when possible
- Use relative paths that work across different environments
- Consider file permissions and ownership requirements

## Integration Points

### Ansible Integration
- Generated inventory file enables seamless Ansible playbook execution
- Automatically includes connection parameters
- Supports both development and production environments

### Future Extensions
Templates can be extended to support:
- Multiple droplet configurations
- Environment-specific variables
- Additional configuration management tools
- Custom application configurations