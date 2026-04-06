# DNS Configurations

Check current configuration.
```bash
nmcli connection show
```
Set Wi-fi and Ethernet to use Cloudflare's DNS over the ISP's.
```bash
sudo nmcli connection modify "preconfigured" ipv4.dns "1.1.1.1 1.0.0.1"
sudo nmcli connection modify "preconfigured" ipv4.ignore-auto-dns yes
sudo nmcli connection down "preconfigured"
sudo nmcli connection up "preconfigured"

sudo nmcli connection modify "Wired connection 1" ipv4.dns "1.1.1.1 1.0.0.1"
sudo nmcli connection modify "Wired connection 1" ipv4.ignore-auto-dns yes
sudo nmcli connection down "Wired connection 1"
sudo nmcli connection up "Wired connection 1"
```
Test configuration.
```bash
nmcli device show INTERFACE | grep IP4.DNS
```