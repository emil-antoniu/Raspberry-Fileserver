#!/bin/bash

# Update software
echo "Updating software..."
sudo apt update && sudo apt upgrade -y

# Install qbittorrent-nox
echo "Installing qBittorrent-nox..."
sudo apt install qbittorrent-nox -y

# Install ExpressVPN
echo "Installing ExpressVPN..."
wget https://www.expressvpn.works/clients/linux/expressvpn-linux-universal-5.1.0.12141_release.run
chmod u+x ./expressvpn-linux-universal-5.1.0.12141_release.run
mkdir -p ~/tmp
TMPDIR=~/tmp ./expressvpn-linux-universal-5.1.0.12141_release.run --nodiskspace

# Install UFW
echo "Installing UFW..."
sudo apt install ufw -y

# Install iperf3
echo "Installing iperf3..."
sudo apt install iperf3 -y

# Install speedtest-cli
echo "Installing speedtest-cli..."
sudo apt install speedtest-cli -y

# Configure qBittorrent-nox service
echo "Configuring qBittorrent-nox service..."
cat <<EOF | sudo tee /etc/systemd/system/qbittorrent-nox.service
[Unit]
Description=qBittorrent-nox
After=network.target

[Service]
User=system-administrator
ExecStart=/usr/bin/qbittorrent-nox
Restart=always

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable qbittorrent-nox
sudo systemctl start qbittorrent-nox

# Configure UFW
echo "Configuring UFW..."
sudo ufw allow ssh
sudo ufw default deny incoming
sudo ufw allow 53/udp # DNS
sudo ufw allow 53/tcp # Additional DNS functions
sudo ufw allow 67:68/udp # DHCP
# qBittorrent ports
sudo ufw allow 8080/tcp # Web UI
sudo ufw allow 57683/tcp # Main port TCP
sudo ufw allow 57683/udp # Main port UDP
sudo ufw allow 6881:6889/tcp # Optional peer connection ports TCP
sudo ufw allow 6881:6889/udp # Optional peer connection ports UDP

echo "Setup complete. Please configure qBittorrent WebUI and ExpressVPN settings manually, and enable the firewall."
