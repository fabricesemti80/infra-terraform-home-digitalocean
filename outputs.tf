output "droplet_ip_address" {
  description = "The public IP address of the do-server-1 droplet"
  value       = digitalocean_droplet.do-server-1.ipv4_address
}

output "ssh_command" {
  description = "SSH command to connect to the droplet"
  value       = "ssh -i ~/.ssh/id_clouds_fs root@${digitalocean_droplet.do-server-1.ipv4_address}"
}

output "web_url" {
  description = "URL to access the nginx web server"
  value       = "http://${digitalocean_droplet.do-server-1.ipv4_address}"
}

output "current_ip_allowed" {
  description = "Current IP address allowed through the firewall"
  value       = chomp(data.http.current_ip.response_body)
}

output "firewall_name" {
  description = "Name of the created firewall"
  value       = digitalocean_firewall.ssh_only.name
}

# Generate Ansible inventory file
resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.yml.tpl", {
    droplet_ip = digitalocean_droplet.do-server-1.ipv4_address
    ssh_key_path = var.pvt_key
  })
  filename = "../../ansible/infra-ansible-home-digitalocean/inventory.yml"
}