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

# Configure ExpressVPN
echo "Configuring ExpressVPN..."
expressvpn preferences set auto_connect true
expressvpn preferences set block_ads true
expressvpn preferences set block_adult true
expressvpn preferences set block_all true
expressvpn preferences set block_malicious true
expressvpn preferences set block_trackers true
expressvpn preferences set desktop_notifications false
expressvpn preferences set disable_ipv6 true
expressvpn preferences set lightway_cipher auto
expressvpn preferences set network_lock strict
expressvpn preferences set preferred_protocol auto
expressvpn preferences set send_diagnostics true

# Configure UFW
echo "Configuring UFW..."
sudo ufw allow ssh
sudo ufw default deny incoming
sudo ufw allow 8080/tcp
sudo ufw allow 57683/tcp
sudo ufw allow 57683/udp
sudo ufw allow 6881:6889/tcp
sudo ufw allow 6881:6889/udp
sudo ufw enable

echo "Setup complete. Please configure qBittorrent WebUI settings manually."
