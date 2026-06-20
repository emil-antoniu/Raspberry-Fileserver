read -r -p "This is a demo on standard physical volume management commands."
# Mounted an empty thumb drive for the demo
lsblk
sudo pvs --verbose --all
sudo pvscan --verbose --allpvs
read -r
sudo pvcreate --verbose /dev/sda1
read -r
sudo pvs --verbose --all
sudo pvscan --verbose --allpvs
read -r
sudo pvdisplay --verbose /dev/sda1
read -r
sudo pvresize --verbose --setphysicalvolumesize 1G /dev/sda1
read -r
sudo pvdisplay --verbose /dev/sda1
read -r
sudo pvremove --verbose /dev/sda1
read -r
lsblk
sudo pvs --verbose --all
sudo pvscan --verbose --allpvs