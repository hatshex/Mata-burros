Pre Requisitos

```
$ pip3 install avro-pyhton3
$ bin/logstash-plugin install logstash-codec-avro
```

Crear topicos

```
/home/hatshex/confluent/bin/kafka-topics --zookeeper localhost:2181 --create --topic AvroInput --partitions 1 --replication-factor 1 

/home/hatshex/confluent/bin/kafka-topics --zookeeper localhost:2181 --create --topic AvroOutput --partitions 1 --replication-factor 1 
```
