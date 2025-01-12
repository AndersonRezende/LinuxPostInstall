#!/usr/bin/env bash

echo "Configurando a chave SSH para o Github"
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa 

if command -v firefox > /dev/null 2>&1; then
	cat ~/.ssh/id_rsa.pub | xclip 
	firefox https://github.com/settings/key
	echo "Crie uma nova chave SSH no seu github e aperte CTRL + V no campo key."
	echo "[CONFIGURADO] - SSH key"
else
	echo "Falha ao configurar a chave SSH para o Github"
fi