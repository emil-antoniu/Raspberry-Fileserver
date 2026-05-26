echo "The ring buffer is a cyclic data structure that has a fixed size, and is hard-coded into the kernel. Users can display data stored in the kernel ring buffer through the dmesg command or the /var/log/boot>
echo -e -n "\n"
read -r  -p "Hit ENTER for a view into dmesg output."
echo -e -n "\n"
dmesg | tail
echo -e -n "\n\n"

read -r -p "Next up: dmidecode. My Pi does not support DMI, therefore, here is a wall of text:"
echo -e -n "\n"
man dmidecode | head --lines=37 | tail --lines=30