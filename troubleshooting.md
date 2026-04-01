# Troubleshooting

## Public key authentication

Raspberry Pi Imager requires a specific format for recognizing public keys, typically OpenSSH format:

`ssh-rsa KEY...`

## FILESERVER not showing up on the network
- Ensure SSID was configured correctly.

## Default User
- The default user should be **"pi"** if no user was manually set.

## ExpressVPN

- Ensure the app is up to date. Updating it might raise errors related to memory:

```
Verifying archive integrity...  100%   MD5 checksums are OK. All good.
Uncompressing ExpressVPN
Not enough space left in /tmp (213064 KB) to decompress ./expressvpn-linux-universal-5.1.0.12141_release.run (495292 KB)
Use --nodiskspace option to skip this check and proceed anyway
Consider setting TMPDIR to a directory with more free space.
```

- A workaround is to use a different TMPDIR.

`mkdir -p ~/tmp`

`TMPDIR=~/tmp ./expressvpn-linux-universal-5.1.0.12141_release.run`

## UFW and Network Applications
- UFW might block network applications, e.g., `qbittorrent-nox`. Disabling it should help narrow down the problem.
- There are specific UFW rules for `qbittorrent-nox`, based on port numbers.  
- Check qBittorrent's ports in use with:  
  ```bash
  sudo netstat -tulnp | grep qbittorrent
- Test theoretical throughput for network interface with iperf3. The first command should be run on a PC on the network.
  ```bash
  iperf3 -s
  ```
  ```bash
  iperf3 -c <PC_IP>
  ```

## Samba
- View active share configurations:
```bash
testparm -s
```

## qbittorrent slow speeds
Tried the following DNS configuration to no avail:
```
nmcli connection show

sudo nmcli connection modify "preconfigured" ipv4.dns "1.1.1.1 1.0.0.1"
sudo nmcli connection modify "preconfigured" ipv4.ignore-auto-dns yes
sudo nmcli connection down "preconfigured"
sudo nmcli connection up "preconfigured"

sudo nmcli connection modify "Wired connection 1" ipv4.dns "1.1.1.1 1.0.0.1"
sudo nmcli connection modify "Wired connection 1" ipv4.ignore-auto-dns yes
sudo nmcli connection down "Wired connection 1"
sudo nmcli connection up "Wired connection 1"

nmcli device show wlan0 | grep IP4.DNS
```
as well as the following client configurations:
- Tools>Options>Connection:
- Enabled Protocol - set to TCP (just TCP, not 'TCP and uTP')
- Uncheck all boxes under 'Listening Port' and 'Connections Limits'.
- Tools>Options>Speed: Uncheck all boxes under 'Rate Limits Settings'.
<br>
After further troubleshooting, the VPN seems to be the issue. Compromised by switching over to OpenVPN UDP.
