# Mounting External Storage on Startup

<p>External storage can be connected to expand storage size, however, the Raspberry barely provides sufficient power for external drives.</p>

<p>Check storage details:</p>

```bash
lsblk -o NAME,UUID,MOUNTPOINT,FSTYPE
```
Add the following line, replacing `XXXXX` with the actual UUID:
```bash
sudo nano /etc/fstab

UUID=XXXXX /media/hdd ntfs-3g defaults,noatime,bigwrites 0 2
```
Easy way to mount the drive:
```bash
sudo mount -a
```

Or double-check partition name and then mount using fully specified path:
```bash
sudo mount /dev/sda1 /media/hdd
```