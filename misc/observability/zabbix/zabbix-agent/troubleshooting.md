# Known issues

Trying to query system properties raises the following error:

```
~ $ zabbix_get -s 192.168.1.23 -k system.uptime
ZBX_NOTSUPPORTED: Received empty response from Zabbix Agent at [192.168.1.23]. Assuming that agent dropped connection because of access permissions.
```

On the agent, ensuring that the following line in `/etc/zabbix/zabbix_agentd.conf`:
`Server=SERVER_IP`
instead allows the Docker network + LAN network ranges fixed the issue.
i.e.
`Server=NETWORK_IP/SUBNET_RANGE`