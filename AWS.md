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
sudo pip install awscli
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
$ chdmod 4000 key.pem
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

## Y el storage???? S3
Ah... creamos un bucket en s3
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

Using High-Level s3 Commands with the AWS Command Line Interface
``` shell
chdmod 4000 *my-file*.pem
```
