Script must be allowed to run without a password.

Edit `sudo`ers:

`sudo visudo`

Add:

`system-administrator ALL=(ALL) NOPASSWD: /usr/sbin/folder`