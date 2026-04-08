Wired 2 buttons to allow enabling and disabling of the Firewall and the VPN for troubleshooting, without having to connect to the Raspberry Pi.

Install this one library:

```
sudo apt install python3-rpi.gpio
```

Script must be allowed to run without a password.

Edit `sudo`ers:

`sudo visudo`

Add:

`system-administrator ALL=(ALL) NOPASSWD: /usr/sbin/folder`