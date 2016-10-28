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

### 7.- Funcionó???
Ubuntu instala por default la versión 2.7 de python, si tu haces un `pip install ipython` en cualquier parte, descargará el ipython para la versión 2.7.
```
hatshex@infernomundo:~/proyectos$ pwd
/home/hatshex/proyectos
hatshex@infernomundo:~/proyectos$ ipython
Python 2.7.12 (default, Jul  1 2016, 15:12:24) 
Type "copyright", "credits" or "license" for more information.

IPython 5.1.0 -- An enhanced Interactive Python.
?         -> Introduction and overview of IPython's features.
%quickref -> Quick reference.
help      -> Python's own help system.
object?   -> Details about 'object', use 'object??' for extra details.

In [1]: 

```

Ahora, crea una carpeta **programming-for-ds** y crea el archivo **.python-version** con tu editor preferido, en mi caso utilizaré nano
```
nano .python-version
```
el cuál solamente tendrá la versión de python que quiero utilizar en esa carpeta
```
3.5.2
```
Ahora dentro de esa carpeta **programming-for-ds** ejecuta
`pip install ipython`

una vez que termine, ejecutas el comando `ipython` y verás que la versión que toma es la 3.5.2

```
programming-for-ds$ ipython
Python 3.5.2 (default, Oct 28 2016, 13:10:43) 
Type "copyright", "credits" or "license" for more information.

IPython 5.1.0 -- An enhanced Interactive Python.
?         -> Introduction and overview of IPython's features.
%quickref -> Quick reference.
help      -> Python's own help system.
object?   -> Details about 'object', use 'object??' for extra details.

In [1]: 

```
