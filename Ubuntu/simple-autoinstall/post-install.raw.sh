#!/bin/bash
renderer=$(networkctl status | grep -i 'networkmanager')
if [ -n "$renderer" ]; then
    echo "The current network renderer is NetworkManager. This script requires networkd. Please change the renderer to networkd before continuing."
    exit 1
fi
read -p "Enter the new hostname: " new_hostname
sudo hostnamectl set-hostname "$new_hostname"
read -sp "Enter the new password for the admin user: " admin_password
echo "admin:${admin_password}" | sudo chpasswd
read -p "Enter the static IP address: " static_ip
read -p "Enter the gateway: " gateway
read -p "Enter the search domains (comma-separated): " search_domains
interface=$(ip -o link show | awk -F': ' '{print $2}' | grep '^e' | head -n1)
sudo tee /etc/netplan/00-installer-config.yaml > /dev/null <<EOF
network:
    version: 2
    renderer: networkd
    ethernets:
        $interface:
            dhcp4: no
            dhcp6: no
            addresses: [$static_ip/24]
            nameservers:
                search: [$search_domains]
                addresses: [1.1.1.1,1.0.0.1]
            routes:
                - to: default
                  via: $gateway
EOF
sudo chmod 600 /etc/netplan/00-installer-config.yaml
sudo netplan apply
sudo reboot
