resource "digitalocean_firewall" "hybrid_security" {
  name = "hybrid-security-firewall"

  droplet_ids = [digitalocean_droplet.do-server-1.id]

##^ INBOUND RULES ^##
  # Emergency SSH access from your IP only
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["${chomp(data.http.current_ip.response_body)}/32"]
  }

  # Beszel Agent port
  inbound_rule {
    protocol         = "tcp"
    port_range       = "45876"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Tailscale ports
  # Tailscale uses UDP port 41641 for direct connections
  inbound_rule {
    protocol         = "udp"
    port_range       = "41641"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Tailscale HTTPS for coordination server (fallback)
  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Kestra
  inbound_rule {
    protocol         = "tcp"
    port_range       = "8080"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

##^ OUTBOUND RULES ^##
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