# La maldición de python y sus versiones!!!!
¿Alguna vez te has enfrentado al problema de tener instaladas las versiones 2.7 y 3.5 de python?, la forma mas sencilla de hacerlo para **Ubuntu** es instalar pyenv.

### 1.- Pre requisitos
``` shell
sudo apt-get update 
sudo apt-get upgrade
## En caso de que no esté instalado git
sudo apt-get install git
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils
```

### 2.- Descargamos y configuramos variables de ambiente
``` shell
cd
git clone git://github.com/yyuu/pyenv.git .pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
source ~/.bashrc
```
### 3.- Revisamos
```shell
$ pyenv global
system
$ pyenv versions
* system (set by /home/hatshex/.pyenv/version)
```
### 4.- Instalamos la versión que requerimos, en este caso la 3.5.2

```
$ pyenv install 3.5.2
```
### 5.- Revisamos la versión
```
$pyenv versions
system
* 3.5.2 (set by /home/hatshex/proyectos/programming-for-ds/.python-version)

```

### 6.- Declaramos que la versión global sea la 3.5.2
```
pyenv global 3.4.0
```
