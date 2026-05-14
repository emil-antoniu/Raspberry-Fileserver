My Windows device is hosting the Zabbix server-side resources within Docker Desktop.

In PowerShell, create a Docker network:

```ps1
docker network create --subnet 172.20.0.0/16 --ip-range 172.20.240.0/20 zabbix-net
```

To verify existing networks, use:

```ps1
docker network ls
```

To delete the network, use:

```ps1
docker network rm zabbix-net
```

To view persistent data storage (volumes) for Docker, use:

```ps1
docker volume ls
```

To remove existing volumes:

```ps1
docker volume prune -f
```

To create a Docker container running Postgres, use:

```ps1
docker run --name postgres-server -t `
  -e POSTGRES_USER="zabbix" `
  -e POSTGRES_PASSWORD="zabbix_pwd" `
  -e POSTGRES_DB="zabbix" `
  --network=zabbix-net `
  --restart unless-stopped `
  -d postgres:latest
```

To create a Docker container running Zabbix SNMP traps, use:

```ps1
docker run --name zabbix-snmptraps -t `
  -v /zbx_instance/snmptraps:/var/lib/zabbix/snmptraps:rw `
  -v /var/lib/zabbix/mibs:/usr/share/snmp/mibs:ro `
  --network=zabbix-net `
  -p 162:1162/udp `
  --restart unless-stopped `
  -d zabbix/zabbix-snmptraps:alpine-7.4-latest
```

To create a Docker container running Zabbis server with Postgres and SNMP traps, use:

```ps1
docker run --name zabbix-server-pgsql -t `
  -e DB_SERVER_HOST="postgres-server" `
  -e POSTGRES_USER="zabbix" `
  -e POSTGRES_PASSWORD="zabbix_pwd" `
  -e POSTGRES_DB="zabbix" `
  -e ZBX_ENABLE_SNMP_TRAPS="true" `
  --network=zabbix-net `
  -p 10051:10051 `
  --volumes-from zabbix-snmptraps `
  --restart unless-stopped `
  -d zabbix/zabbix-server-pgsql:alpine-7.4-latest
```

To create a Docker container running Zabbix WebUI, use:

```ps1
docker run --name zabbix-web-nginx-pgsql -t `
  -e ZBX_SERVER_HOST="zabbix-server-pgsql" `
  -e DB_SERVER_HOST="postgres-server" `
  -e POSTGRES_USER="zabbix" `
  -e POSTGRES_PASSWORD="zabbix_pwd" `
  -e POSTGRES_DB="zabbix" `
  --network=zabbix-net `
  -p 443:8443 `
  -p 80:8080 `
  -v /etc/ssl/nginx:/etc/ssl/nginx:ro `
  --restart unless-stopped `
  -d zabbix/zabbix-web-nginx-pgsql:alpine-7.4-latest
```

To remove these containers, use:

```ps1
docker stop zabbix-web-nginx-pgsql zabbix-server-pgsql zabbix-snmptraps postgres-server
```
```ps1
docker rm zabbix-web-nginx-pgsql zabbix-server-pgsql zabbix-snmptraps postgres-server
```

Reference:
https://www.zabbix.com/documentation/current/en/manual/installation/containers