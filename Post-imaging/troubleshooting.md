# Troubleshooting

## FILESERVER not showing up on the network
- Ensure SSID was configured correctly.

## Default User
- The default user should be **"pi"** if no user was manually set.

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
