#!/usr/bin/env bash

echo "Instalando o Google Chrome"
pamac build google-chrome ---no-confirm > /dev/null 2>&1
if command -v google-chrome-stable > /dev/null 2>&1; then
	echo "[INSTALADO] - Google Chrome"
else
	echo "Falha ao instalar o Google Chrome"
fi