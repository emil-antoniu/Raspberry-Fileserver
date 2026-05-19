Install zabbix-agent:

```
apt install zabbix-agent
```

Edit these specific entries in the config:
```
sudo nano /etc/zabbix/zabbix_agentd.conf
```
```
Server=<IP of Windows host or Docker-published IP>
ServerActive=<IP of Windows host or Docker-published IP>
Hostname=<exact host name used in Zabbix UI>
```

Restart to apply changes:

```
sudo systemctl restart zabbix-agent
```

Confirm that zabbix-agent is listening on TCP port 10050:

```
sudo ss -tulpn | grep 10050
```

Ensure that a firewall entry is added:

```
sudo ufw allow 10050/tcp
```
```
sudo ufw status
```