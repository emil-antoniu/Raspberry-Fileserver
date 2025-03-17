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
