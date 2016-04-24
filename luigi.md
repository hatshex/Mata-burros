![Esquema del archivo etl.py](images/LuigiETL.png)

Modificamos el archivo de Dockerfile que está en la carpeta producto/ambiente/luigi/luigi_worker

Luego volvemos a construir el docker-compose

```shell
$ sudo docker-compose rm --force luigi_worker
$ sudo docker-compose build --force-rm --no-cache luigi_worker
```
Solamente levantamos postgres spark y luigi
```shell docker-compose up -d postgres spark_worker luigid```

Dentro de Luigi_worker, si queremos probar los archivos .py que utilizan pyspark

* Ejecutar el contenedor de luigi
* Actualizamos el repo
* Levantar spark
```zsh
$ docker exec -it ambiente_luigi_worker_1 bin/bash
$ git pull
```
**Ojo ->** si ejecutamos solamente ```shell $ pyspark ```nos conecta a un minicluster de la máquina de Luigi, y no queremos hacer pruebas con eso.. queremos que corra en el verdadero cluster de spark.

```shell 
$ pyspark --master spark:\\master:7077 -- packages com.amazonaws:aws-java-sdk-pom:1.10.34,org.apache.hadoop:hadoop-aws:2.6.0,com.databricks:spark-csv_2.11:1.4.0
```
**_La primera vez se tarda pq los paquetes se instalan por primera vez en el cluster_**
Una vez que termina la instalación de los paquetes, nos aparece la consola de spark donde podemos pegar nuestros códigos( 
**_aggregated_by_state.py, top_10.py_**) individualmente y ver como se comportan, antes de que Luigi los ejecute. Por ejemplo:

```shell
$ avistamientos = sqlCtx.read.format('com.databricks.spark.csv')\
                               .options(header='true', inferSchema='true', delimiter='\t')\
                               .load(s3n:\\mybucket\ufo\raw)

```

Ah... pero y cómo sabemos que Luigi también está funcionando???
* Salimos de spark Ctrl + c
* python -m luigi --module **nombre del archivo con el etl** **Clase que queremos probar**
```zsh
$ python -m luigi --module etl ReadUFOS
```
