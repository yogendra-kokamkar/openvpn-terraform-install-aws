#!/bin/bash
set -eux

# Log output for debugging
exec > /var/log/user-data.log 2>&1

# Wait for cloud-init to finish
sleep 30

# Update and install necessary packages
export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get upgrade -y
apt-get install -y curl iptables-persistent net-tools

# Enable IP forwarding
echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
sysctl -p

# Download and make the OpenVPN script executable
curl -O https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh
chmod +x openvpn-install.sh

# Headless install
export AUTO_INSTALL=y
./openvpn-install.sh <<EOF
yes
EOF

# Wait just in case and copy the client config
sleep 20
cp /root/client.ovpn /home/ubuntu/client.ovpn
chown ubuntu:ubuntu /home/ubuntu/client.ovpn
chmod 644 /home/ubuntu/client.ovpn
