# Setup for Image Backups

```bash
sudo mkdir /media/usb
```

## Mount External Drive
*Mount the external drive onto which the image will be copied. Double-check partition name.
```bash
sudo mount /dev/sda1 /media/usb
sudo su
sudo dd if=/dev/mmcblk0 bs=4M | gzip > /media/usb/arc-fileserver-backup.img.gz
```

# Startup

## Starting qBittorrent-nox on Boot
```bash
sudo nano /etc/systemd/system/qbittorrent-nox.service
```
Add the following content:
```ini
[Unit]
Description=qBittorrent-nox
After=network.target

[Service]
User=pi
ExecStart=/usr/bin/qbittorrent-nox
Restart=always

[Install]
WantedBy=multi-user.target
```
Enable and start the service:
```bash
sudo systemctl enable qbittorrent-nox  
sudo systemctl start qbittorrent-nox  
```

# ExpressVPN Configurations

| Field                 | Value  |
|-----------------------|--------|
| auto_connect         | true   |
| block_ads           | false   |
| block_adult         | false   |
| block_all           | false   |
| block_malicious     | false   |
| block_trackers      | false   |
| desktop_notifications | false |
| disable_ipv6        | true   |
| lightway_cipher     | auto   |
| network_lock        | off |
| preferred_protocol  | udp   |
| send_diagnostics    | false   |

# UFW Configurations
```bash
sudo ufw allow ssh
sudo ufw default deny incoming
```
Allow qBittorrent-nox WebUI:
```bash
sudo ufw allow 8080/tcp
```
Allow qBittorrent-nox to listen on port 57683:
```bash
sudo ufw allow 57683/tcp  
sudo ufw allow 57683/udp  
```
Allow default peer communication ports:
```bash
sudo ufw allow 6881:6889/tcp  
sudo ufw allow 6881:6889/udp  
```
Allow FTPS for LAN file sharing:
```bash
TO BE DETERMINED
```

# qBittorrent-nox Configurations

## WebUI
- Change default username and password.
- Use the interface with the VPN only (generally `tun0`).
- Change default save path to `TO BE DETERMINED`.
- Disable UPnP.
- Automatically add torrents from `TO BE DETERMINED`.

# DNS Configurations
Check current configuration.
```bash
nmcli connection show
```
Set Wi-fi and Ethernet to use Cloudflare's DNS over the ISP's.
```bash
sudo nmcli connection modify "preconfigured" ipv4.dns "1.1.1.1 1.0.0.1"
sudo nmcli connection modify "preconfigured" ipv4.ignore-auto-dns yes
sudo nmcli connection down "preconfigured"
sudo nmcli connection up "preconfigured"

sudo nmcli connection modify "Wired connection 1" ipv4.dns "1.1.1.1 1.0.0.1"
sudo nmcli connection modify "Wired connection 1" ipv4.ignore-auto-dns yes
sudo nmcli connection down "Wired connection 1"
sudo nmcli connection up "Wired connection 1"
```
Test configuration.
```bash
nmcli device show INTERFACE | grep IP4.DNS
```
