# Para eliminar el uso de sudo 
* Abrimos una terminal y ejecutamos
```zsh
sudo visudo
```
* Esto abre un archivo, en la sección **_# User privilege specification_** agrega tu usuario
```zsh
# User privilege specification
root    ALL=(ALL:ALL) ALL
TuUsuario ALL=(ALL:ALL) ALL
```
* Cierras la terminal y reinicias.... listo!!!! no mas sudo ....

