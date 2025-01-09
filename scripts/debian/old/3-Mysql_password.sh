#!/usr/bin/env bash

# Configuração do MySql
######### MYSQL #########
PASSWORD='root'
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$PASSWORD';"
sudo mysql -p"$PASSWORD" -e "flush privileges;"
######### MYSQL #########
