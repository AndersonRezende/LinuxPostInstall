#!/bin/bash

echo "Instalando JetBrains Toolbox"

# Define a URL da API da JetBrains para obter o link da versão mais recente (Linux)
URL="https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release"
DOWNLOAD_URL=$(curl -s $URL | grep -oP '"linux":\s*\{\s*"link":\s*"\K[^"]+')

mkdir -p /tmp/jetbrains-toolbox
sudo mkdir -p /opt/jetbrains-toolbox
curl -L "$DOWNLOAD_URL" -o /tmp/jetbrains-toolbox/toolbox.tar.gz >/dev/null 2>&1

sudo tar -xzf /tmp/jetbrains-toolbox/toolbox.tar.gz -C /opt/jetbrains-toolbox --strip-components=1 >/dev/null 2>&1
sudo /opt/jetbrains-toolbox/jetbrains-toolbox >/dev/null 2>&1 &

echo "[INSTALADO] - JetBrains Toolbox"