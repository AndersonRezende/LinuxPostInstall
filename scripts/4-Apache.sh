#!/usr/bin/env bash

# Configuração do apache
######### APACHE #########
sudo ufw app list
sudo ufw allow in "Apache"
sudo systemctl restart apache2
response=$(curl --write-out '%{http_code}' --silent --output /dev/null http://localhost)
if [[ "$response" -ne 200 ]]
then
    echo "Houve um erro ao instalar o apache"
    exit 1
fi
######### APACHE #########