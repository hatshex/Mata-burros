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
| Descripción | Ruta| Permisos |
| :---------------:|:-------------:|:------------:|
| Configuración | /etc/neo4j/neo4j.conf | Solo Lectura | 
| Data | /var/lib/neo4j/data | Lectura y Escritura |
| Logs | /var/log/neo4j | Lectura y Escritura |
| Métricas | /var/lib/neo4j/metrics | Lectura y Escritura |
| Import | /var/lib/neo4j/import  o /usr/share/neo4j/import*| Solo Lectura |
| Bin | /usr/share/neo4j/bin | Ejecución |
| Lib | /usr/share/neo4j/lib | Solo Lectura |
| Plugins | /var/lib/neo4j/plugins | Solo Lectura |

** Si no existe la carpeta, hay que crearla
## Para probarlo?
Ve a cualquier browser que tengas y ve a la [ruta](http://localhost:7474), el usuario y password iniciales son neo4j/neo4j, se solicitará cambiar el password la primera vez que se ingresa.

## Manuales
* http://guides.neo4j.com/reco/
## No olvides tunear tu máquina
http://neo4j.com/docs/operations-manual/current/performance/

## Bibliografía
* http://neo4j.com/docs/cypher-refcard/current/
* http://debian.neo4j.org/?_ga=1.80385943.1833551628.1487600906
* http://neo4j.com/docs/operations-manual/current/configuration/file-locations/
