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
Replace contents with the following, only for <b>testing</b> access:
```
[global]
   workgroup = WORKGROUP
   server string = Raspberry Pi Samba Server
   security = user
   map to guest = Bad User

[microSD]
   comment = AUXILIARY STORAGE UNIT
   path = /home/USERNAME/Downloads
   browseable = yes
   writable = yes
   create mask = 0777
   directory mask = 0777
   guest ok = yes
   public = yes
   force user = USERNAME
```
For restricted access, use:
```
[global]
   workgroup = WORKGROUP
   server string = Raspberry Pi Samba Server
   security = user
   map to guest = never

[microSD]
   comment = AUXILIARY STORAGE UNIT
   path = /home/USERNAME/Downloads
   browseable = yes
   writable = yes
   valid users = USERNAME
   force user = USERNAME
   create mask = 0770
   directory mask = 0770
   public = no
```
Remember to create a user, as SMB has a separate database from the one that holds system accounts.
```
sudo smbpasswd -a USERNAME
```
Restart Samba:
```
sudo systemctl restart smbd
sudo systemctl status smbd
```