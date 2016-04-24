Modificamos el archivo de Dockerfile que está en la carpeta producto/ambiente/luigi/luigi_worker

Luego volvemos a construir el docker-compose

```shell
sudo docker-compose rm --force luigi_worker
sudo docker-compose build --force-rm --no-cache luigi_worker
Solamente levantamos postgres spark y luigi
docker-compose up -d postgres spark_worker luigid
```
Dentro de Luigi_worker, si queremos probar nuestro ETL,

1.- Ejecutar el docker
3.- Actualizamos el repo
2.- Levantar spark
```zsh
$ docker exec -it ambiente_luigi_worker_1 bin/bash
$ git pull
$ pyspark --master spark:\\master:7077

```

