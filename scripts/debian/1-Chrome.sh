#!/usr/bin/env bash

# Instalação do Chrome
######### GOOGLE CHROME #########
if command -v "google-chrome" > /dev/null 2>&1; then
    echo "[INSTALADO] - Google Chrome"
else
    echo "[INSTALANDO] - Google Chrome"
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O chrome.deb > /dev/null 2>&1
    sudo dpkg -i chrome.deb
    rm chrome.deb
    echo "[INSTALADO] - Google Chrome"
fi
######### GOOGLE CHROME #########