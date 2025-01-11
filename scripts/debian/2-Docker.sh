#!/usr/bin/env bash

# Instalação do Docker
######### DOCKER #########
if command -v "docker" > /dev/null 2>&1; then
    echo "[INSTALADO] - Docker"
else
    echo "[INSTALANDO] - Docker"

    # Uninstall all conflicting packages
    for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done > /dev/null 2>&1

    # Add Docker's official GPG key:
    sudo apt-get install -y ca-certificates curl > /dev/null 2>&1
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc > /dev/null 2>&1
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update > /dev/null 2>&1
    sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin > /dev/null 2>&1
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose > /dev/null 2>&1
    sudo chmod +x /usr/local/bin/docker-compose

    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker
    sudo chown $USER /var/run/docker.sock
    
    echo "[INSTALADO] - Docker"
fi
######### DOCKER #########
