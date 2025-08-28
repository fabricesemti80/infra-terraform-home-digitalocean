# Product Overview

This is a Terraform infrastructure project that provisions a single DigitalOcean droplet with security-focused configuration. The project creates:

- A Ubuntu 22.04 droplet in NYC2 region with minimal specs (1 CPU, 512MB RAM, 10GB disk)
- SSH-only firewall that restricts access to the current public IP address
- Automatic generation of Ansible inventory file for configuration management
- Cloud-init user data for basic system updates

The infrastructure is designed for development/testing purposes with a focus on security by default - only allowing SSH access from the deploying machine's IP address.