read -r -p "First command we will look at is: depmod"
echo -e -n "\n"
man depmod | head --lines=22 | tail --lines=6
read -r -p "Hit ENTER for a view into depmod output."
echo -e -n "\n"
depmod --verbose | head
echo -e -n "\n\n"

# read -r -p "Next up: insmod"

# read -r -p "Next up: lsmod"

# read -r -p "Next up: modinfo"

# read -r -p "Next up: modprobe"

# read -r -p "Next up: rmmod"