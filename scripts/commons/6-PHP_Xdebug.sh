#!/usr/bin/env bash

######### CONFIGURAÇÃO DO XDEBUG #########
echo "[CONFIGURANDO] - XDEBUG"
X_DEBUG_FILE="/etc/php/conf.d/99-xdebug.ini"

# Verifica se o arquivo já contém as configurações necessárias
if grep -q "zend_extension=xdebug.so" "$X_DEBUG_FILE" && \
   grep -q "xdebug.mode=debug" "$X_DEBUG_FILE" && \
   grep -q "xdebug.start_with_request=yes" "$X_DEBUG_FILE" && \
   grep -q "xdebug.client_host=127.0.0.1" "$X_DEBUG_FILE" && \
   grep -q "xdebug.client_port=9003" "$X_DEBUG_FILE"; then
    echo "As configurações do Xdebug já estão presentes no arquivo $X_DEBUG_FILE."
else
    echo "Adicionando configurações do Xdebug ao arquivo $X_DEBUG_FILE..."
    cat <<EOL | sudo tee -a "$X_DEBUG_FILE"

; Configuração do Xdebug
zend_extension=xdebug.so
xdebug.mode=debug
xdebug.start_with_request=yes
xdebug.client_host=127.0.0.1
xdebug.client_port=9003
xdebug.log=/var/log/xdebug.log
EOL
    echo "Configurações do Xdebug adicionadas."
fi

# Criar diretório de log do Xdebug (se não existir)
if [ ! -d "/var/log" ]; then
    echo "Criando o diretório /var/log..."
    sudo mkdir -p /var/log
fi

# Criar arquivo de log do Xdebug (se não existir) e ajustar permissões
if [ ! -f "/var/log/xdebug.log" ]; then
    echo "Criando o arquivo de log do Xdebug..."
    sudo touch /var/log/xdebug.log
    sudo chmod 666 /var/log/xdebug.log
else
    echo "O arquivo de log do Xdebug já existe."
fi

echo "[CONFIGURADO] - XDEBUG"
######### CONFIGURAÇÃO DO XDEBUG #########
