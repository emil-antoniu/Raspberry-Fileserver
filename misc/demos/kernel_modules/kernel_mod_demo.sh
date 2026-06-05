read -r -p "First command we will look at is: depmod"
echo -e -n "\n"
man depmod | head --lines=22 | tail --lines=6
read -r -p "Hit ENTER for a view into depmod output."
echo -e -n "\n"
depmod --verbose | head
echo -e -n "\n\n"

# read -r -p "Next up: insmod"

read -r -p "Next up: lsmod"
echo -e -n "\n"
man lsmod | head --lines=10 | tail --lines=1
read -r -p "Hit ENTER for a view into lsmod output."
lsmod | head
echo -e -n "\n\n"

read -r -p "Next up: modinfo"
echo -e -n "\n"
man modinfo | head --lines=15 | tail --lines=2
read -r -p "Hit ENTER for a view into modinfo output (targeting the module xt_nat as an example)."
modinfo xt_nat
echo -e -n "\n\n"

# read -r -p "Next up: modprobe"

# read -r -p "Next up: rmmod"