data "digitalocean_ssh_key" "terraform" {
  name = "id_clouds_fs"
}

data "http" "current_ip" {
  url = "https://ipinfo.io/ip"
}