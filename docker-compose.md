# Create topics on docker-compose

docker-compose exec broker kafka-topics --create --zookeeper \
zookeeper:2181 --replication-factor 1 --partitions 1 --topic users

# List topics
sudo docker-compose exec kafka  \
  kafka-console-consumer --bootstrap-server localhost:29092 --topic raw  --from-beginning


# Create consumer on docker-compose
docker-compose exec kafka  \
  kafka-console-consumer --bootstrap-server localhost:29092 --topic raw  --from-beginning
