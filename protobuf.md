# Pre requisitos
```
sudo apt-get install libprotobuf-java protobuf-compiler
sudo gem install ruby-protocol-buffers



## Correr logstash
bin/logstash -f config/KafkaProtobuf.conf --config.reload.automatic
```


## Logstash

Archivo de configuración KafkaProtobuf.conf

```
input {
	kafka
	{
	 bootstrap_servers=>  "localhost:9092"
	 topics => "JsonTest"
	 auto_offset_reset => "none" 
	 #codec => "json"
	 #codec => "rubydebug" 
	 codec => protobuf
	 {
	   class_name => "ComprobanteType"
	   include_path => ['/home/hatshex/logstash/config/test.pb.rb']
	  
	 }
	}
}

filter {
  mutate {
    remove_field => [ "msg" ]
  }
}


output {
  #stdout { codec => "json" }
  stdout { codec => "rubydebug" }
}
```


Ejecutar Logstash
```
bin/logstash -f config/KafkaProtobuf.conf
```
