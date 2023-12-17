#!/bin/bash

# Check if all arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <role> <number>"
    exit 1
fi

role=$1
number=$2

# Set IP address and hostname based on role and number
if [ "$role" = "master" ]; then
    ip="10.1.1.$number"
    hostname="master$number"
elif [ "$role" = "worker" ]; then
    ip="10.1.2.$number"
    hostname="worker$number"
else
    echo "Invalid role specified. Valid roles are 'master' or 'worker'."
    exit 1
fi

# Check the current network renderer
renderer=$(networkctl status | grep -i 'networkmanager')

if [ -n "$renderer" ]; then
    echo "The current network renderer is NetworkManager. This script requires networkd. Please change the renderer to networkd before continuing."
    exit 1
fi

# Set hostname
hostnamectl set-hostname $hostname

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
            addresses: [$ip/16]
            nameservers:
                search: [aquabrain.lan]
                addresses: [10.1.0.1]
            routes:
                - to: default
                  via: 10.1.0.1
EOF

# Set permissions for the netplan configuration file
sudo chmod 600 /etc/netplan/00-installer-config.yaml

# Apply the netplan configuration
sudo netplan apply

echo "Post-install script completed successfully. "