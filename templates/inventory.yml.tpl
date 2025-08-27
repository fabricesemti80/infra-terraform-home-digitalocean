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