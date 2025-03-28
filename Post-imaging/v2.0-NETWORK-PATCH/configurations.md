# Setup for Image Backups

```bash
sudo mkdir /media/usb
```

## Mount External Drive
Mount the external drive onto which the image will be copied. Double-check partition name.
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
```bash
expressvpn preferences set field value
```
| Field                 | Value  |
|-----------------------|--------|
| auto_connect         | true   |
| block_ads           | true   |
| block_adult         | true   |
| block_all           | true   |
| block_malicious     | true   |
| block_trackers      | true   |
| desktop_notifications | false |
| disable_ipv6        | true   |
| lightway_cipher     | auto   |
| network_lock        | strict |
| preferred_protocol  | auto   |
| send_diagnostics    | true   |

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
Allow Samba for LAN file sharing:
```bash
sudo ufw allow Samba
sudo ufw enable
```

# qBittorrent-nox Configurations

## WebUI
- Change default username and password.
- Use the interface with the VPN only (generally `tun0`).
- Change default save path to `/media/hdd`.
- Disable UPnP.
- Automatically add torrents from `/media/hdd`.
