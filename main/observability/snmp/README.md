Install SNMP.

```
sudo apt update
sudo apt install snmp snmpd -y
```

Create a user, but first stop the service.

```
sudo systemctl stop snmpd
```

```
sudo net-snmp-create-v3-user
```

Configure snmpd.conf:

```
agentAddress udp:161

# Restrict access to a single IP
rouser snmpuser authPriv 192.168.1.X 
```

Restart SNMP:

```
sudo systemctl start snmpd
sudo systemctl enable snmpd
```