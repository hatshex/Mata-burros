* Bajar confluent
* Bajar logstash
* Inicializamos Confluent
```
$ /home/hatshex/confluent-oss/bin/confluent start
```
* Creamos tópicos
``` shell
$ /home/hatshex/confluent-oss/bin/kafka-topics --zookeeper localhost:2181 --create --topic catalogos --partitions 1 --replication-factor 1

$ /home/hatshex/confluent-oss/bin/kafka-topics --zookeeper localhost:2181 --create --topic facturas --partitions 1 --replication-factor 1
```

* Sacamos información de ElasticSearch y la metemos a Kafka, creamos los archivos de configuración de logstash `logstashcatalogos.conf`
``` ruby
input {
	elasticsearch
        {
        hosts => ["localhost:9200"]
        index => "catalogos_*"
        query => '{ "query": { "query_string": { "query": "*" } } }'
        size => 500
        scroll => "5m"
        docinfo => true

        user => "elastic"
        password => "########"
        }
}

output 
{

stdout{ codec=> rubydebug}
  kafka
    {
      acks =>"all"
      bootstrap_servers=>  ["localhost:9092"]
      buffer_memory => 104857600
      max_request_size=> 104857600
      message_key=> "%{[id_catalogo]}"
      retries => 3
      send_buffer_bytes => 104857600
      topic_id => ["catalogos"]
      codec => json { charset => "UTF-8"}
      buffer_memory =>104857600
    }
}

```

* Ejecutamos logstash
```
$ /home/hatshex/logstash/bin/logstash -f config/logstashcatalogos.conf
$ /home/hatshex/logstash/bin/logstash -f config/logstashfacturas.conf
```

* Entrar al cliente del KSQL
```
/home/hatshex/confluent/bin/ksql
```

* Si la información hay que leerla desde el principio ( --from-beginning), hay que setear el offset.
``` shell
                  
                  ===========================================
                  =        _  __ _____  ____  _             =
                  =       | |/ // ____|/ __ \| |            =
                  =       | ' /| (___ | |  | | |            =
                  =       |  <  \___ \| |  | | |            =
                  =       | . \ ____) | |__| | |____        =
                  =       |_|\_\_____/ \___\_\______|       =
                  =                                         =
                  =  Streaming SQL Engine for Apache Kafka® =
                  ===========================================

Copyright 2017 Confluent Inc.

CLI v4.1.1, Server v4.1.1 located at http://localhost:8088

Having trouble? Type 'help' (case-insensitive) for a rundown of how things work!

ksql> SET 'auto.offset.reset' = 'earliest';

```
* Listar tópicos
``` shell
ksql> SHOW topics;

 Kafka Topic                            | Registered | Partitions | Partition Replicas | Consumers | Consumer Groups 
---------------------------------------------------------------------------------------------------------------------
 __confluent.support.metrics            | false      | 1          | 1                  | 0         | 0               
 _confluent-ksql-default__command_topic | true       | 1          | 1                  | 0         | 0               
 _schemas                               | false      | 1          | 1                  | 0         | 0               
 connect-configs                        | false      | 1          | 1                  | 0         | 0               
 connect-offsets                        | false      | 25         | 1                  | 0         | 0               
 connect-statuses                       | false      | 5          | 1                  | 0         | 0               
 catalogos                              | true       | 1          | 1                  | 2         | 2               
 facturas                               | true       | 1          | 1                  | 1         | 1               
---------------------------------------------------------------------------------------------------------------------
```
* Crear la tabla de los catálogos, el stream de las facturas y el stream con el join.
```
ksql> CREATE STREAM catalogos ( campo01 VARCHAR, campo02 VARCHAR, campo03 VARCHAR ) WITH (KAFKA_TOPIC='catalogos', VALUE_FORMAT='json');

ksql> CREATE TABLE facturas  ( fcampo01 VARCHAR,  fcampo02 VARCHAR, fcampo03 VARCHAR, fcampo04 VARCHAR, fcampo05 VARCHAR, fcampo06 VARCHAR)  WITH (KAFKA_TOPIC='facturas', VALUE_FORMAT='json', KEY='fcampo01');

ksql> CREATE STREAM facturas_enriquecidas AS SELECT  * FROM facturas facturas LEFT JOIN catalogos catalogos ON facturas.fcampo01=catalogos.campo01;   
```

* Listar tópicos
``` shell
ksql> SHOW topics;

 Kafka Topic                            | Registered | Partitions | Partition Replicas | Consumers | Consumer Groups 
---------------------------------------------------------------------------------------------------------------------
 __confluent.support.metrics            | false      | 1          | 1                  | 0         | 0               
 _confluent-ksql-default__command_topic | true       | 1          | 1                  | 0         | 0               
 _schemas                               | false      | 1          | 1                  | 0         | 0               
 FACTURAS_ENRIQUECIDAS                  | true       | 4          | 1                  | 4         | 1               
 connect-configs                        | false      | 1          | 1                  | 0         | 0               
 connect-offsets                        | false      | 25         | 1                  | 0         | 0               
 connect-statuses                       | false      | 5          | 1                  | 0         | 0               
 padron                                 | true       | 1          | 1                  | 2         | 2               
 reproceso                              | true       | 1          | 1                  | 1         | 1               
---------------------------------------------------------------------------------------------------------------------
```

### Bibliografía
- https://www.confluent.io/blog/ksql-in-action-real-time-streaming-etl-from-oracle-transactional-data
- https://github.com/confluentinc/ksql/blob/master/docs/syntax-reference.rst
- https://docs.confluent.io/current/ksql/docs/syntax-reference.html
