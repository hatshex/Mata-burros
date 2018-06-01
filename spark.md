# Cómo instalar Apache Spark en Ubuntu
### Pre requisitos
  - Instalación de Java
```
$ java -version
java version "1.8.0_171"
Java(TM) SE Runtime Environment (build 1.8.0_171-b11)
Java HotSpot(TM) 64-Bit Server VM (build 25.171-b11, mixed mode)

```
### Instalación de Apache Spark
  - Descargar el instalador en la página `http://spark.apache.org/downloads.html`
```
$ wget https://www.apache.org/dyn/closer.lua/spark/spark-2.3.0/spark-2.3.0-bin-hadoop2.7.tgz
```
   - Descomprimir
```
$ cd /home/hatshex/Descargas/ 
$ tar –xvf spark-2.3.0-bin-hadoop2.7.tgz
$ mv spark-2.3.0-bin-hadoop2.7 /opt/spark
```
   - Agregar variables de ambiente
```
$ sudo nano ~/.zshrc

export SPARK_HOME=/opt/spark
export PATH=$SPARK_HOME/bin:$PATH
```
   - Verificar la instalación en la terminal
```
$ spark-shell
Spark session available as 'spark'.
Welcome to
      ____              __
     / __/__  ___ _____/ /__
    _\ \/ _ \/ _ `/ __/  '_/
   /___/ .__/\_,_/_/ /_/\_\   version 2.3.0
      /_/
         
Using Scala version 2.11.8 (Java HotSpot(TM) 64-Bit Server VM, Java 1.8.0_171)
Type in expressions to have them evaluated.
Type :help for more information.

scala> 
```
```
$ pyspark
Welcome to
      ____              __
     / __/__  ___ _____/ /__
    _\ \/ _ \/ _ `/ __/  '_/
   /__ / .__/\_,_/_/ /_/\_\   version 2.3.0
      /_/
Using Python version 3.5.2 (default, Jul  2 2016 17:53:06)
SparkSession available as 'spark'.
>>>
```
### PySpark en Jupyter
  - Para configurar el driver de PySpark

```
$ sudo nano ~/.zshrc
export SPARK_HOME=/opt/spark
export PATH=$SPARK_HOME/bin:$PATH
export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS='notebook'
```
