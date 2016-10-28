# TensorFlow

### Pre requisitos
Hay que tener actualizado el ubuntu y tener instalado los paquetes pip y dev

```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install python-pip python-dev
```

### Variables de entorno, dependiendo de la versión de python que uses, 2.7 ó 3.5 en mi caso
```
# Ubuntu/Linux 64-bit, CPU only, Python 2.7
$ export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.11.0rc1-cp27-none-linux_x86_64.whl

# Ubuntu/Linux 64-bit, CPU only, Python 3.5
$ export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.11.0rc1-cp35-cp35m-linux_x86_64.whl
```
### Utilizamos pip para instalar
```
# Python 2
$ sudo pip install --upgrade $TF_BINARY_URL

# Python 3
$ sudo pip3 install --upgrade $TF_BINARY_URL
```
