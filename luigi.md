Modificamos el archivo de Dockerfile que está en la carpeta producto/ambiente/luigi/luigi_worker

Luego volvemos a construir el docker-compose

```shell
sudo docker-compose rm --force luigi_worker
sudo docker-compose build --force-rm --no-cache luigi_worker
Solamente levantamos postgres spark y luigi
docker-compose up -d postgres spark_worker luigid
```
Dentro de Luigi_worker, si queremos probar nuestro ETL

* Ejecutar el docker
* Actualizamos el repo
* Levantar spark
```zsh
$ docker exec -it ambiente_luigi_worker_1 bin/bash
$ git pull
$ pyspark --master spark:\\master:7077 -- packages com.amazonaws:aws-java-sdk-pom:1.10.34,org.apache.hadoop:hadoop-aws:2.6.0,com.databricks:spark-csv_2.11:1.4.0
```
**_La primera vez se tarda pq los paquetes se instalan por primera vez en el cluster_**

**Ojo ->** si ejecutamos solamente ```shell $ pyspark ```nos conecta a un minicluster de la máquina de Luigi, y no queremos hacer pruebas con eso.. queremos que corra en el verdadero cluster de spark.
