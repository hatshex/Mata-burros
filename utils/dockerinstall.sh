#!/bin/bash
# ********************************* By hatshex *******************************
# Pre-requisitos, el archivo debe tener permisos de ejecución, en caso de que no: sudo chmod +x dockerinstall.sh
# Ejemplos de ejecución: 
# sudo ./dockerinstall.sh 
# ********************************* By hatshex *******************************


sudo apt-get update 
sudo apt-get install apt-transport-https ca-certificates

sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo apt-get install linux-image-extra-$(uname -r)
sudo apt-get update
sudo apt-get install docker-engine
service docker start
systemctl enable docker
