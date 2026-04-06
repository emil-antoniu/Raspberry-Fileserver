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