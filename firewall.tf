resource "digitalocean_firewall" "hybrid_security" {
  name = "hybrid-security-firewall"

  droplet_ids = [digitalocean_droplet.do-server-1.id]

  # Emergency SSH access from your IP only
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["${chomp(data.http.current_ip.response_body)}/32"]
  }

  # Tailscale coordination port (required for Tailscale to function)
  inbound_rule {
    protocol         = "tcp"
    port_range       = "45876"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Full outbound access (unchanged)
  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}