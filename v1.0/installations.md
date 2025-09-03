# Update software

```sh
sudo apt update && sudo apt upgrade -y
```

# Install qbittorrent-nox for file sharing

```sh
sudo apt install qbittorrent-nox -y
```

# Install ExpressVPN

Different versions available at [ExpressVPN's official site](https://www.expressvpn.com/setup#linux).

```sh
wget https://www.expressvpn.works/clients/linux/expressvpn_3.83.0.2-1_armhf.deb
sudo dpkg -i expressvpn_*.deb
sudo apt --fix-broken install
```

# Install Samba Share

```sh
sudo apt install samba -y
```

# Install UFW

```sh
sudo apt install ufw -y
```
