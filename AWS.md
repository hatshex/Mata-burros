# Tuto para instalar AWS CLI y no morir en el intento
Solamente para Ubuntu, para mejor referencia [Installing the AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/installing.html#install-bundle-other-os)

# Lo primero es tener instalado el aws cli

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
$ sudo pip install awscli
```
* Ahora si, ya tenemos pip... 
```shell
$ sudo pip install awscli
```

## Para verificar que este instalado 
```shell
$ aws help
```
Desplegará el manual del comando aws, para salir le ponen q

## Una vez que tenemos listo el ambiente, entramos a la consola de AWS [AWS Management Console](https://aws.amazon.com/console/)

### Creamos un usuario
* Security & Identify
- Clic en Identify & Access Management (IAM)
- Clic en Users
- Clic en Create New User
- Agregar el o los usuarios que requieren, por ejemplo: hatshex-dpa
- Una vez creado, descarguen las credenciales(Clic en Show Credentials) y descargará el archivo "credentials.csv" **Nunca nunca nunca pierdan este archivo, y jamás las publiquen en su github o algún otro repositorio...**
- En este momento, tenemos el usuario peeeeeerrroooo no tiene permisos de hacer ni m....

### Agregamos roles y permisos [Access Management](http://docs.aws.amazon.com/IAM/latest/UserGuide/access.html)
* Clic en el usuario
* Clic pestaña permissions
* Clic en Attach Policy
* Seleccionas tantos permisos necesites y clic en Attach Policy
* Ya tenemos el usuario listo.

### Crear una máquinita EC2 en AWS
* Clic Create Instance
* Launch Instance
* Choose an Amazon Machine Image (AMI)
  - Seleccionamos -> Ubuntu Server 14.04 LTS (HVM)
  - Seleccionamos -> t2.micro -> Clic en Review & Launch
  - En la pantalla que despliega, es importante revisar que tengamos activado el protocolo SSH que nos sirve para conectarnos.
  - Clic en Launch
  - Desplegará una ventana para generar las keys pair (Llave pública y llave privada)
  - Create a new pair -> Escribir el nombre
  ó
  - Choose key pair -> Seleccionar el archivo .pem previamente creado
  - Descargar el archivo .pem **Nunca nunca nunca pierdan este archivo, y jamás las publiquen en su github o algún otro repositorio...**
  - Clic Launch
  - Si regresamos a la pantalla de Instances, veremos que ya está la máquinita prendida.

### Ahora si, aws desde la consola de línea de comandos
* Abran una terminal
* Abrimos y pegamos las credenciales del archivo que descargamos ("credentials.csv")
```shell
$ aws configure
AWS Access Key ID [None]: ** Aquí van las credenciales que descargaron
AWS Secret Access Key [None]: ** Aquí van las credenciales que descargaron
Default region name [None]: us-west-2
Default output format [None]: json
```
* Una vez configurado el aws cli, movemos el archivo .pem a la carpeta ~/.ssh y le cambiamos los permisos. Si no existe la carpeta hay que crearla.... la expresión ~/ se refiere a la carpeta de tu usuario.

``` shell
$ mkdir /home/hatshex/.ssh
$ mv /home/hatshex/key.pem /home/hatshex/.ssh
$ chmod 4000 key.pem
```
* Abrimos o creamos el archivo config, dentro de la carpeta ~/.ssh/ y pegamos la siguiente configuración. **Utilizamos el usuario ubuntu, pq es el que se crea por default en la instancia de ec2 que creamos previamente.**
```shell
$ nano ~/.ssh/config
```
```shell
Host *.amazonaws.com
  IdentityFile ~/.ssh/key.pem
  User ubuntu
```
* Ahora si, podemos probar que se conecte a la máquina de ec2 en amazon
```shell
$aws ec2 describe-instances | \
jq '.Reservations[].Instances[] |  {PublicDnsName, InstanceId, PublicIpAddress}'
```
* Tendremos la siguiente salida
```shell
{
  "PublicDnsName": "ec2-54-213-74-99.us-west-2.compute.amazonaws.com",
  "InstanceId": "i-0ca605cb",
  "PublicIpAddress": "54.213.74.99"
}
```
* Guardamos la info en el archivo instancias
```shell
aws ec2 describe-instances | \
jq '.Reservations[].Instances[].PublicDnsName' | \
tr '"' ' ' > instancias
```
* Conectándote a tu máquina ec2 desde ssh 
```shell
$ ssh -i ~/.ssh/key.pem ec2-user@ec2-54-201-99-166.us-west-2.compute.amazonaws.com
```
**_ El parámetro ec2-54-201-99-166.us-west-2.compute.amazonaws.com es el Public DNS_**
* Ahora si... estamos dentro de nuestra ec2
```shell
Welcome to Ubuntu 14.04.3 LTS (GNU/Linux 3.13.0-74-generic x86_64)

 * Documentation:  https://help.ubuntu.com/

  System information as of Mon Apr 18 21:33:05 UTC 2016

  System load: 0.0               Memory usage: 5%   Processes:       81
  Usage of /:  10.0% of 7.74GB   Swap usage:   0%   Users logged in: 0

  Graph this data and manage this system at:
    https://landscape.canonical.com/

  Get cloud support with Ubuntu Advantage Cloud Guest:
    http://www.ubuntu.com/business/services/cloud


Last login: Mon Apr 18 21:18:34 2016 from 159.16.249.211
ubuntu@ip-172-31-45-18:~$ 

```
## Y el storage???? S3
Ah... creamos un bucket en s3 [Using High-Level s3 Commands with the AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/using-s3-commands.html)
```shell
aws s3 mb s3://bucket-name
```
Y si me equivoqué??
```shell
aws s3 rb s3://bucket-name --force
```
Mmmm y cómo obtengo la lista de buckets???
```shell
aws s3 ls
```
## No olviden apagar las instancias!!!!! 

### Apagar las instancias desde cli??
```shell
$ sudo ec2-stop-instances i-10a64379
```
* Debes tener instalado el ec2-api-tools
```shell 
$ sudo apt-get install ec2-api-tools
```

### Y si quiero crear varias instancias desde cli? [Create Instance](http://docs.aws.amazon.com/cli/latest/reference/opsworks/create-instance.html)
```shell 
$ aws opsworks --region us-east-1 create-instance --stack-id 935450cc-61e0-4b03-a3e0-160ac817d2bb --layer-ids 5c8c272a-f2d5-42e3-8245-5bf3927cb65b --hostname myinstance1 --instance-type m1.large --os "Amazon Linux"
```
