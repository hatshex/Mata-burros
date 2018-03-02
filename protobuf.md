# Pre requisitos protobuf
```
sudo apt-get install libprotobuf-dev
sudo apt-get install libprotobuf-java protobuf-compiler
sudo gem install ruby-protocol-buffers

$protoc --version
libprotoc 3.0.0

$ruby-protoc --version
ruby-protoc 1.6.1

$ruby --version
ruby 2.3.3p222 (2016-11-21) [x86_64-linux-gnu]
```
## Protobuf
Lo primero que tenemos que hacer es crear nuestro archivo Protobuf, con la estructura que vayamos a requerir, en este ejemplo usamos la versión 2.0 de protobuf.
Las tags 1 y 2 marcan cada elemento como único tags. Los tags 1-15 requieren un byte menos.


```
//Archivo addressbook.proto
syntax = "proto2";

package tutorial;

message Person {
  required string timestamp = 1;
  required string version =2;
  required string name = 17;
  required int32 id = 18;
  optional string email = 19;
  optional int32 phone=20;
}
```

```
ruby-protoc addressbook.proto  	
protoc --python_out=. addressbook.proto


protoc --encode=tutorial.person addressbook.proto > addressbook.bin

protoc --decode=tutorial.person addressbook.proto < addressbook.bin

protoc --decode_raw < addressbook.bin

```

## Logstash - Protobuf
1. [Descargar Logstash](https://www.elastic.co/downloads/logstash)
2. Extraer los archivos de logstash
3. Hay 2 formas de instalar el codec de protobuf
	1. Instalar el codec de logstash
	```
	bin/logstash-plugin install logstash-codec-protobuf
	```
	2. [Descargar el archivo gem](https://rubygems.org/downloads/logstash-codec-protobuf-1.0.5.gem). Abrir una terminal(ctrl + alt + t), ir a la dirección donde está logstash, entrar en la carpeta bin y ejecutar el siguiente comando:
	```
	logstash-plugin install /path/to/downloaded/logstash-codec-protobuf-1.0.5.gem
	```
4. Crear el archivo de configuración de Logstash, siempre debe contener las secciones de Input y Output. En este ejemplo vamos a recibir un json y lo vamos a mandar a un tópico en kafka con el codec de protobuf KafkaProtobuf.conf

```
input {
    kafka
    {
     bootstrap_servers=>  "localhost:9092"
     topics => "JsonProtobuf"   
     auto_offset_reset => "earliest"
     codec => "json"
    }
}

filter{
    json{
        source => "message"
   }
}


output {
    stdout{codec =>json}

    kafka
    {
     bootstrap_servers=>  "localhost:9092"
     topic_id => "ProtobufLogstash1"
        codec => protobuf
        {
            class_name => "Tutorial::Person"
            protobuf_version_3 => false
            include_path => ['/home/hatshex/Proyectos/logstash/config/addressbook.pb.rb']
        }

    }
}
```


Ejecutar Logstash
```
bin/logstash -f config/KafkaProtobuf.conf
```
