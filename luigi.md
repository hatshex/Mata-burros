Modificamos el archivo de Dockerfile que está en la carpeta producto/ambiente/luigi/luigi_worker

Luego volvemos a construir el docker-compose

```shell
sudo docker-compose rm --force luigi_worker
sudo docker-compose build --force-rm --no-cache luigi_worker
Solamente levantamos postgres spark y luigi
docker-compose up -d postgres spark_worker luigid
```
