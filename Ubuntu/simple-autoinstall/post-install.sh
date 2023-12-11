#!/bin/bash

# Check the current network renderer
renderer=$(networkctl status | grep -i 'networkmanager')

if [ -n "$renderer" ]; then
    echo "The current network renderer is NetworkManager. This script requires networkd. Please change the renderer to networkd before continuing."
    exit 1
fi

# Prompt the user for the new hostname
read -p "Enter the new hostname: " new_hostname

# Change the hostname
sudo hostnamectl set-hostname "$new_hostname"

# Prompt the user for the new password for the admin user
read -sp "Enter the new password for the admin user: " admin_password

# Change the password for the admin user
echo "admin:${admin_password}" | sudo chpasswd

# Prompt the user for the static IP address
read -p "Enter the static IP address: " static_ip

# Prompt the user for the gateway
read -p "Enter the gateway: " gateway

# Prompt the user for the search domains
read -p "Enter the search domains (comma-separated): " search_domains

# Get the name of the first Ethernet interface
interface=$(ip -o link show | awk -F': ' '{print $2}' | grep '^e' | head -n1)

# Create the netplan configuration file
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



# Set permissions for the netplan configuration file
sudo chmod 600 /etc/netplan/00-installer-config.yaml

# Apply the netplan configuration
sudo netplan apply

# Reboot the server
sudo reboot
