# Tuto para instalar AWS CLI y no morir en el intento
Solamente para Ubuntu

## Instalar AWS CLI con el bundle installer
* Descargar el instalador, utilizando curl, tmb puedes utilizar el comando wget
* Descomprimir el paquete de awscli-bundle.zip
* Ejecutar el instalador

``` shell
$ sudo curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
$ sudo unzip awscli-bundle.zip
$ sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
``` 

## Instalar AWS CLI a través de pip
* Debes tener instalado python versión 2.7 o posterior; si no la tienes... para instalarlo utiliza el comando:
```shell
$ sudo apt-get install python2.7
```
* Después descarga el script de instalación y ejecútalo
```shell
$ sudo curl -O https://bootstrap.pypa.io/get-pip.py
$ sudo python27 get-pip.py
sudo pip install awscli
```
* Ahora si, ya tenemos pip... 
```shell
$ sudo pip install awscli
```


Modificando permisos al archivo .pem
``` shell
chdmod 4000 *my-file*.pem
```
