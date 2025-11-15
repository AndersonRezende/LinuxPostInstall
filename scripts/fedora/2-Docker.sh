#!/usr/bin/env bash

# Instalação do Docker
######### DOCKER #########
if command -v "docker" > /dev/null 2>&1; then
    echo "[INSTALADO] - Docker"
else
    echo "[INSTALANDO] - Docker"

    # Uninstall all conflicting packages
    sudo dnf remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

    # Add the repository to Apt sources:
    sudo dnf -y install dnf-plugins-core
    sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
    
    # Install
    sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin > /dev/null 2>&1
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose > /dev/null 2>&1
    sudo chmod +x /usr/local/bin/docker-compose

    # Start Docker Engine
    sudo systemctl enable --now docker

    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker
    sudo chown $USER /var/run/docker.sock
    
    echo "[INSTALADO] - Docker"
fi
######### DOCKER #########
