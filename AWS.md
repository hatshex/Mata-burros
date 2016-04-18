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
- Una vez creado, descarguen las credenciales(Clic en Show Credentials) y descargará el archivo "credentials.csv" ** Nunca nunca nunca pierdan este archivo, y jamás las publiquen en su github o algún otro repositorio...**
- En este momento, tenemos el usuario peeeeeerrroooo no tiene permisos de hacer ni m....

### Agregamos roles y permisos [Access Management](http://docs.aws.amazon.com/IAM/latest/UserGuide/access.html)
* Clic en el usuario
* Clic pestaña permissions
* Clic en Attach Policy
* Seleccionas tantos permisos necesites y clic en Attach Policy
* Ya tenemos el usuario listo.

### Ahhhh un último paso... generar las Access Keys 
Mas info en [Managing Access Keys for IAM Users](ttp://docs.aws.amazon.com/console/iam/access-keys)
* Clic en el nombre del usuario
* Seleccionar la pestaña Security Credentials
* Clic en Access Keys
* Clic Create Access Keys

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

### Crear una máquinita EC2 en AWS
* Clic Create Instance
* Launch Instance
* Choose an Amazon Machine Image (AMI)
  - Seleccionamos -> Ubuntu Server 14.04 LTS (HVM)
  - Seleccionamos -> t2.micro -> Clic en Review & Launch
  - En la pantalla que despliega, es importante revisar que tengamos activado el protocolo SSH que nos sirve para conectarnos.

``` shell
chdmod 4000 *my-file*.pem
```
