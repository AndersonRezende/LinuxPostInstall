#!/usr/bin/env bash


sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo groupadd docker
sudo usermod -aG docker ${USER}
sudo chown $USER /var/run/docker.sock 

echo "Instalando o Docker"
sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo groupadd docker
sudo usermod -aG docker ${USER}
sudo chown $USER /var/run/docker.sock 
if command -v docker > /dev/null 2>&1; then
	echo "[INSTALADO] - Docker"
else
	echo "Falha ao instalar o Docker"
fi