#!/bin/bash

# Instalação do Chrome
######### GOOGLE CHROME #########
if is_installed "google-chrome"; then
    echo "O Google Chrome já está instalado."
else
    echo "Inciando instalação do Google Chrome."
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O $DOWNLOAD_FILES_DIR/chrome.deb
    sudo dpkg -i $DOWNLOAD_FILES_DIR/chrome.deb
fi
######### GOOGLE CHROME #########