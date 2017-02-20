# Pasos para instalar Neo4J en Ubuntu

## Agregamos el repositorio y actualizamos
```
wget -O - https://debian.neo4j.org/neotechnology.gpg.key | sudo apt-key add -
echo 'deb https://debian.neo4j.org/repo stable/' | sudo tee /etc/apt/sources.list.d/neo4j.list
sudo apt-get update
```

## Instalamos la última versión de Neo4j Community Edition
```
sudo apt-get install neo4j
```

## Revisamos que el servicio esté corriendo
```
sudo service neo4j status
```

## Para que el servicio arranque al iniciar la máquina
```
sudo systemctl enable neo4j
```
## Python
```
sudo pip install neo4jrestclient
```

## Es importante saber las rutas de los archivos de configuración, datos, logs, etc..
* Configuración /etc/neo4j/neo4j.conf
* Data /var/lib/neo4j/data
* Logs /var/log/neo4j
* Métricas /var/lib/neo4j/metrics
* Import /var/lib/neo4j/import
* Bin /usr/share/neo4j/bin
* Lib /usr/share/neo4j/lib
* Plugins /var/lib/neo4j/plugins

## Bibliografía
* http://debian.neo4j.org/?_ga=1.80385943.1833551628.1487600906
