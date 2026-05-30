echo "The ring buffer is a cyclic data structure that has a fixed size, and is hard-coded into the kernel. Users can display data stored in the kernel ring buffer through the dmesg command or the /var/log/boot>
echo -e -n "\n"
read -r -p "Hit ENTER for a view into dmesg output."
echo -e -n "\n"
dmesg | tail
echo -e -n "\n\n"

read -r -p "Next up: dmidecode. My Pi does not support DMI, therefore, here is a wall of text:"
echo -e -n "\n"
man dmidecode | head --lines=37 | tail --lines=30
echo -e -n "\n\n"

read -r -p "Next up: IPMI. My Pi lacks a BMC(2) which is needed for IPMI to work(3), therefore, here is a brief definition from the manual of ipmitool:"
echo -e -n "\n"
# ipmitool needs to be installed
man ipmitool | head --lines=43 | tail --lines=3
echo -e -n "\n\n"

# read -r -p "Next up: lm_sensors."

read -r -p "Next up: lscpu."
echo -e -n "\n"
man lscpu | head --lines=12 | tail --lines=3
read -r -p "Hit ENTER for a view into lscpu output."
lscpu
echo -e -n "\n\n"

read -r -p "Next up: lshw."
echo -e -n "\n"
man lshw | head --lines=18 | tail --lines=2
read -r -p "Hit ENTER for a shortened view into lshw output."
# lshw needs to be installed
lshw -short -sanitize
echo -e -n "\n\n"

# read -r -p "Next up: lsmem."

read -r -p "Next up: lspci. My Pi has no PCI slots, therefore, here is a brief definition from the manual:"
echo -e -n "\n"
man lspci | head --lines=10 | tail --lines=1
echo -e -n "\n\n"

read -r -p "Next up: lsusb."
echo -e -n "\n"
man lsusb | head --lines=11 | tail --lines=2
read -r -p "Hit ENTER for a view into lsusb output."
lsusb
echo -e -n "\n\n"