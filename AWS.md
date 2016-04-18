# Tuto para instalar AWS CLI y no morir en el intento
Estamos usando ubuntu como sistema operativo

Instalar AWS CLI con el bundle installer

``` shell
$ curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
$ unzip awscli-bundle.zip
$ sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
``` 

Modificando permisos al archivo .pem
``` shell
chdmod 4000 *my-file*.pem
```
