# Install Samba

```
sudo apt install samba -y
```

# Configure Samba

Allow Samba for LAN file sharing:
```
sudo ufw allow Samba
```
```
sudo nano /etc/samba/smb.conf
```

For restricted access, use:
```
[global]
   workgroup = WORKGROUP
   server string = Raspberry Pi Samba Server
   security = user
   map to guest = never
   hosts allow = 192.168.1.0/24

[microSD]
   comment = AUXILIARY STORAGE UNIT
   path = /usr/games/samba-shared
   browseable = yes
   writable = yes
   valid users = system-administrator samba-userB
   force user = system-administrator samba-userB
   create mask = 0770
   directory mask = 0770
   public = no
```
Remember to create a system user account for additional Samba users:
```
sudo adduser samba-userB
```
Set a password.

Restrict shell access:
```
sudo usermod -s /usr/sbin/nologin samba-userB
```

Create and enable the Samba accounts:
```
sudo smbpasswd -a USERNAME
sudo smbpasswd -e USERNAME
```
Restart Samba:
```
sudo systemctl restart smbd

sudo systemctl status smbd
```
# Testing

List created Samba users:
```
sudo pdbedit -L
```

Test connection with:

```
sudo apt install smbclient -y
```

```
smbclient //server_ip/share_name -U username
``` 
