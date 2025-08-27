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

# Generate Ansible inventory file
resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.yml.tpl", {
    droplet_ip = digitalocean_droplet.do-server-1.ipv4_address
    ssh_key_path = var.pvt_key
  })
  filename = "../../ansible/infra-ansible-home-digitalocean/inventory.yml"
}