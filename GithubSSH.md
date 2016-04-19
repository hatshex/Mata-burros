# Cómo configurar un github con ssh y no morir en el intento???
* Generamos las llaves utilizando ssh-keygen
```shell
$ ssh-keygen -t rsa -b 4096 -C "your_email@gmail.com"
```
**Nota: Las llaves se deben de generar con el usuario local, no con el root**
* Los archivos generalmente se guardarán en la ruta ~/.ssh/, si no le cambiaste el nombre los identificaras como:
  - id_rsa -> Tu llave privada.... **_Nunca nunca nunca subir a github, dropbox, etc.._**
  - id_rsa.pub -> Tu llave pública, que se deberá configurar en tu perfil de github
```shell
  Enter a file in which to save the key (/home/**TuUsuario**/.ssh/id_rsa): [Press enter]
```
* El sistema te preguntará por una frase, que será como tu password, puedes dejar vacío este campo
```shell
  Enter passphrase (empty for no passphrase): [Type a passphrase]
  Enter same passphrase again: [Type passphrase again]
```
* Ahora revisamos que el ssh-agent esté activo
```shell
$ eval "$(ssh-agent -s)"
Agent pid 59566
```
* Agregamos el archivo de la llave privada(id_rsa) al agente
```shell
$ ssh-add ~/.ssh/id_rsa
```
* 1 2 3 Probando????
```shell
$ ssh-add -l
2048 12:34:56:79:90:12:34:56:78:90:12:34:56:78:90:12 /home/**TuUsuario**/.ssh/id_rsa (RSA)
```
* Imprimimos en pantalla la llave pública
```shell
$ cat ~/.ssh/id_rsa.pub
```
* Copiamos la salida anterior y la agregamos en el perfil de github, Settings/SSH keys and GPG keys/New SSH Keys

* Cómo se clona el repositorio de github, usando los certificados??
```shell
$ git clone git@github.com:hatshex\data-product-architecture.git
```
