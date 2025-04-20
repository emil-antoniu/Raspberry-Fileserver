### Install Samba Share
As neither FTPS nor SFTP were available for the router, the FILESERVER's limited storage will be used with Samba for file sharing. Backups will be made when necessary.
```
sudo apt install samba -y
```
Allow Samba for LAN file sharing:
```
sudo ufw allow Samba
```
```
sudo nano /etc/samba/smb.conf
```
Replace contents with:
```
[global]
   workgroup = WORKGROUP
   server string = Raspberry Pi Samba Server
   security = user
   map to guest = Bad User

[hdd]
   comment = MAIN STORAGE UNIT
   path = /home/pi/Downloads
   browseable = yes
   writable = yes
   create mask = 0777
   directory mask = 0777
   guest ok = yes
   public = yes
   force user = pi
```
Restart Samba:
```
sudo systemctl restart smbd
sudo systemctl status smbd
```
