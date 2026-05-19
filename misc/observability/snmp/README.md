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
sudo net-snmp-create-v3-user -a SHA -x AES
```

Verify user creation:

```
sudo cat /var/lib/snmp/snmpd.conf | grep createUser
```

Configure snmpd.conf:

```
sudo nano /etc/snmp/snmpd.conf
```

```
agentAddress udp:161

view all included .1

rwuser snmp-admin authPriv
```

Test the user:

```
snmpwalk -v3 -l authPriv -u snmp-admin \
-a SHA -A 'SHAPass' \
-x AES -X 'AESPass' \
localhost
```

Restart SNMP:

```
sudo systemctl start snmpd
sudo systemctl enable snmpd
```