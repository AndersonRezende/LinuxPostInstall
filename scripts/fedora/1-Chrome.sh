#!/usr/bin/env bash

# Instalação do Chrome
######### GOOGLE CHROME #########
if command -v "google-chrome" > /dev/null 2>&1; then
    echo "[INSTALADO] - Google Chrome"
else
    echo "[INSTALANDO] - Google Chrome"
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm -O chrome.rpm > /dev/null 2>&1
    sudo dnf install chrome.rpm
    rm chrome.rpm
    echo "[INSTALADO] - Google Chrome"
fi
######### GOOGLE CHROME #########