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

read -r -p "Next up: lscpu."
echo -e -n "\n"
man lscpu | head --lines=12 | tail --lines=3
read -r -p "Hit ENTER for a view into lscpu output."
lscpu
echo -e -n "\n\n"