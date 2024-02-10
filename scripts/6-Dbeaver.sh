#!/usr/bin/env bash

######### DBEAVER #########
if dpkg -s "dbeaver-ce" &> /dev/null || command -v "dbeaver-ce" > /dev/null 2>&1; then
    echo "[INSTALADO] - dbeaver"
else
    echo "[INSTALANDO] - dbeaver"
    wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb -O dbeaver.deb  > /dev/null 2>&1
    sudo dpkg -i dbeaver.deb  > /dev/null 2>&1
    rm dbeaver.deb
    echo "[INSTALADO] - dbeaver"
fi
######### DBEAVER #########