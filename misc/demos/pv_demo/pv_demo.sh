# lvm2 package is needed
# sudo apt install lvm2
read -r -p "First command we will look at is: pvcreate"
echo -e -n "\n"
man pvcreate | head --lines=22 | tail --lines=6
read -r -p "Hit ENTER for..."
echo -e -n "\n"

echo -e -n "\n\n"
# pvdisplay
# pvmove
# pvremove
# pvresize
# pvs
# pvscan