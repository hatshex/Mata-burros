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

Creamos la clase(addressbook_pb2.py) en python con el siguiente comando:
```
protoc --python_out=. addressbook.proto
```
Creamos un programita (addressbook_write.py) en python para escribir archivos
```
#! /usr/bin/python

import addressbook_pb2
import datetime
import sys

# This function fills in a Person message based on user input.
def PromptForAddress(person):
  person.timestamp = format(datetime.datetime.now())
  person.version="1"
  person.id = int(input("Enter person ID number: "))
  person.name = input("Enter name: ")

  email = input("Enter email address (blank for none): ")
  if email != "":
    person.email = email

  number = int(input("Enter a phone number (or leave blank to finish): "))
  if number != "":
    person.phone = number


# Main procedure:  Reads the entire address book from a file,
#   adds one person based on user input, then writes it back out to the same
#   file.
"""
if len(sys.argv) != 2:
  print ("Usage:", sys.argv[0], "ADDRESS_BOOK_FILE")
  sys.exit(-1)

address_book = addressbook_pb2.AddressBook()

# Read the existing address book.
try:
  f = open(sys.argv[1], "rb")
  address_book.ParseFromString(f.read())
  f.close()
except IOError:
  print (sys.argv[1] + ": Could not open file.  Creating a new one.")
"""
address_book = addressbook_pb2.Person()
# Add an address.
PromptForAddress(address_book)

# Write the new address book back to disk.
f = open(sys.argv[1], "wb")
f.write(address_book.SerializeToString())
f.close()
```

Ejecutamos el programa, para crear el archivo addressbook.bin
```
$ python addressbook_write.py addressbook.bin

Enter person ID number: 1
Enter name: hatshex
Enter email address (blank for none): hatshex@gmail.com
Enter a phone number (or leave blank to finish): 12345678

$ cat addressbook.bin
2018-03-02 12:13:02.0958081�hatshex��hatshex@gmail.com����% 
```

Probamos que podamos decodificar la información
```
$ protoc --decode=tutorial.Person addressbook.proto < addressbook.bin

timestamp: "2018-03-02 12:13:02.095808"
version: "1"
name: "hatshex"
id: 1
email: "hatshex@gmail.com"
phone: 12345678


$ protoc --decode_raw < addressbook.bin
1: "2018-03-02 12:13:02.095808"
2: "1"
17: "hatshex"
18: 1
19: "hatshex@gmail.com"
20: 12345678

```
Ahora necesitamos crear la clase de ruby que utilizaremos en logstash con el codec de protobuf

``` ruby
ruby-protoc addressbook.proto  	
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

Ejemplo del json
```
{"timestamp":"2018-03-01T12:00:57.164Z","version":"1","name":"hatshex","id":1,"email":"hatshex@gmail.com","phone":12345678}
```

Enviamos json al topico de kafka
```
$ cat addressbook.json |  ~/confluent-4.0.0/bin/kafka-console-producer --topic JsonProtobuf --broker-list localhost:9092
```
