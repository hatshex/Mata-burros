El presente tutorial es para Ubuntu 17.10

Docker Quick Start
https://docs.confluent.io/current/installation/docker/docs/quickstart.html

# Requerimientos
  - Git
  - Docker Engine
  - Docker Compose
  - Docker Machine
  - Virtual Box
  
  
# Crear y configurar Docker Machine
  ```
  sudo docker-machine create --driver virtualbox --virtualbox-memory 6000 confluent
  ```
  
  Si todo sale bien, deberás tener una salida como la siguiente:
  
  ```
Running pre-create checks...
Creating machine...
(confluent) Copying /home/hatshex/.docker/machine/cache/boot2docker.iso to /home/hatshex/.docker/machine/machines/confluent/boot2docker.iso...
(confluent) Creating VirtualBox VM...
(confluent) Creating SSH key...
(confluent) Starting the VM...
(confluent) Check network to re-create if needed...
(confluent) Waiting for an IP...
Waiting for machine to be running, this may take a few minutes...
Detecting operating system of created instance...
Waiting for SSH to be available...
Detecting the provisioner...
Provisioning with boot2docker...
Copying certs to the local machine directory...
Copying certs to the remote machine...
Setting Docker configuration on the remote daemon...
Checking connection to Docker...
Docker is up and running!
To see how to connect your Docker Client to the Docker Engine running on this virtual machine, run: docker-machine env confluent

  ```
  
  ## Configure your terminal window to attach it to your new Docker Machine
  ```
  eval $(docker-machine env confluent)
  ```
  Indicando la opción -d los contenedores se iniciarán en segundo plano
Inicializamos los contenedores, la opción -d nos permite que estén en segundo plano, el archivo que se utiliza para crear los contenedores es el docker-compose.yml
```
docker-compose up -d
 ```
Para verificar que los servicios estén arriba:
```
docker-compose ps

                      Name                                     Command               State                           Ports                         
---------------------------------------------------------------------------------------------------------------------------------------------------
kafkastreamsexamples_kafka-create-topics_1          bash -c echo Waiting for K ...   Up      9092/tcp                                              
kafkastreamsexamples_kafka-music-application_1      bash -c echo Waiting for K ...   Up      0.0.0.0:7070->7070/tcp                                
kafkastreamsexamples_kafka-music-data-generator_1   bash -c echo Waiting for K ...   Up      7070/tcp                                              
kafkastreamsexamples_kafka_1                        /etc/confluent/docker/run        Up      0.0.0.0:29092->29092/tcp, 0.0.0.0:9092->9092/tcp      
kafkastreamsexamples_schema-registry_1              /etc/confluent/docker/run        Up      0.0.0.0:8081->8081/tcp                                
kafkastreamsexamples_zookeeper_1                    /etc/confluent/docker/run        Up      2181/tcp, 2888/tcp, 0.0.0.0:32181->32181/tcp, 3888/tcp

 ```
 
Obtener la IP
 ```
 docker-machine ip confluent
 192.168.99.101

 
  ```
 Probar instancias
 ```
 curl -sXGET  http://192.168.99.101:7070/kafka-music/instances | jq
 [
  {
    "host": "localhost",
    "port": 7070,
    "storeNames": [
      "all-songs",
      "song-play-count",
      "top-five-songs",
      "top-five-songs-by-genre"
    ]
  }
]

 ```
 
 Probar top five
 ```
curl -sXGET http://192.168.99.101:7070/kafka-music/charts/top-five | jq
[
  {
    "artist": "Public Enemy",
    "album": "Fear Of A Black Planet",
    "name": "911 Is A Joke",
    "plays": 68
  },
  {
    "artist": "Wheres The Pope?",
    "album": "PSI",
    "name": "Fear Of God",
    "plays": 62
  },
  {
    "artist": "Dead Kennedys",
    "album": "Fresh Fruit For Rotting Vegetables",
    "name": "Chemical Warfare",
    "plays": 59
  },
  {
    "artist": "The Exploited",
    "album": "Totally Exploited",
    "name": "Punks Not Dead",
    "plays": 56
  },
  {
    "artist": "Jello Biafra And The Guantanamo School Of Medicine",
    "album": "The Audacity Of Hype",
    "name": "Three Strikes",
    "plays": 56
  }
]

 ```
