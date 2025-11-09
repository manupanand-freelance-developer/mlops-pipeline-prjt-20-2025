# to make UI accesible at port 8123
- go to  /etc/clickhouse-server/config.xml
- remove the default block adn add below
```<listen_host>0.0.0.0</listen_host>

<!-- Optional: for interserver communication (only needed in clusters)
<interserver_listen_host>0.0.0.0</interserver_listen_host>
-->```