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
read -p "Enter the subnet mask bits (eg: 255.255.255.0 = 24): " subnet_mask_bits
read -p "Enter the gateway: " gateway
read -p "Is the gateway also the DNS server? (y/n): " gateway_is_dns_server
if [ "$gateway_is_dns_server" != "y" ]; then
    read -p "Enter the DNS server(s) (separated by ,): " dns_server
else
    dns_server="$gateway"
fi
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
            addresses: [$static_ip/$subnet_mask_bits]
            nameservers:
                search: [$search_domains]
                addresses: [$dns_server]
            routes:
                - to: default
                  via: $gateway
EOF
sudo chmod 600 /etc/netplan/00-installer-config.yaml
sudo netplan apply
sudo reboot