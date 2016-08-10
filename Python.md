#Python y Anaconda
Si utilizas Windows, te recomiendo que descargues Anaconda:
* Ingresa a la dirección http://continuum.io/downloads.
* Descarga el instalador de Python 2.7, selecciona en el icono de Windows y selecciona "Windows 64-Bit Python 2.7 Graphical Installer". 
  - Para Mac o Linux, realiza el mismo proceso seleccionando la plataforma que utilices.
* Sigue las instrucciones del instalador.
* Si ya tienes instalado Anaconda, ve a la línea de comandos (no olvides correrlo con permisos de Administrador) y ejecuta los siguientes comandos:
```
conda update conda
conda update anaconda
```
  - Esto puede tardar algunos minutos

#IPython Notebook
Una vez instalado y/o actualizado Anaconda, utilizaremos IPython Notebook:
* En el menú de inicio, buscamos y seleccionamos el programa Launcher, nos desplegará una ventana con varios IDE's, en nuestro caso utilizaremos ipython-notebook
* También podemos ejecutarlo desde la línea de comandos (no olvides correrlo con permisos de Administrador)
* Versión anterior a anaconda 4
```
ipython notebook
```
* Versión actual
```
jupyter notebook
```
IPython Notebook utiliza [Markdown](http://daringfireball.net/projects/markdown/syntax)
Algunos tutoriales:
* http://opentechschool.github.io/python-data-intro/core/notebook.html
* https://www.codementor.io/python/tutorial
* https://www.codecademy.com/learn/pythonP

Para instalar librerías
```
conda install -c anaconda gensim=0.12.4
```

Cuando no encuentres una librería de python 3.5* para windows, revisa la url [http://www.lfd.uci.edu/~gohlke/pythonlibs]
* Descarga el archivo Paquete*.whl en tu equipo local
* Abre una ventana de línea de comandos
* Ejecuta la siguiente instrucción
```
> pip install C:\basemap-1.0.8-cp35-none-win_amd64.whl 
 ```
