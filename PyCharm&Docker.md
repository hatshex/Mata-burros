## Agregar usuarios al grupo de docker
```
id -nG
sudo groupadd docker
sudo usermod -aG docker $USER
```
## Modificar permisos
```
sudo chmod a+rwx /var/run/docker.sock
sudo chmod a+rwx /var/run/docker.pid
```
