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
user.avsc
```
{
	"namespace": "example.avro",
	"type": "record",
	"name": "User",
	"fields": [
		{"name": "name", "type": "string"},
		{"name": "favorite_number",  "type": ["int", "null"]},
		{"name": "favorite_color", "type": ["string", "null"]}
	]
}

```

producer.py
```
from kafka import SimpleProducer, KafkaClient
import avro.schema
import io, random
from avro.io import DatumWriter

# To send messages synchronously
kafka = KafkaClient('localhost:9092')
producer = SimpleProducer(kafka)
 
# Kafka topic
topic = "AvroInput"

# Path to user.avsc avro schema
schema_path="user.avsc"
schema = avro.schema.Parse(open(schema_path).read())
 
 
for i in range(10):
    writer = avro.io.DatumWriter(schema)
    bytes_writer = io.BytesIO()
    encoder = avro.io.BinaryEncoder(bytes_writer)
    writer.write({"name": "123", "favorite_color": "111", "favorite_number": random.randint(0,10)}, encoder)
    raw_bytes = bytes_writer.getvalue()
    producer.send_messages(topic, raw_bytes)

```

consumer.py
```
from kafka import KafkaConsumer
import avro.schema
import avro.io
import io

# To consume messages
consumer = KafkaConsumer('AvroInput', bootstrap_servers=['localhost:9092'], auto_offset_reset='smallest')

schema_path="user.avsc"
schema = avro.schema.Parse(open(schema_path).read())

for msg in consumer:
    bytes_reader = io.BytesIO(msg.value)
    decoder = avro.io.BinaryDecoder(bytes_reader)
    reader = avro.io.DatumReader(schema)
    user1 = reader.read(decoder)
    print (user1)
	
```

## Archivo de Configuración de Logstash, Kafka - Elasticsearch
```
input {
    kafka
    {
     bootstrap_servers=>  "localhost:9092"
     topics => "AvroInput"
     #auto_offset_reset => "earliest"
     auto_offset_reset => "latest"
     codec => avro {
        schema_uri => "/home/hatshex/Proyectos/CFDI/python-kafka-avro/user.avsc"
    	}

    }
}

filter {
}


output {
  elasticsearch {
    hosts => ["localhost:9200"]
    index => "user_data"
    document_type => "user"
  }
}

```
