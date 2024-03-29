#!/usr/bin/env bash

echo "[CONFIGURANDO] - Android"
source /etc/profile
source ~/.bashrc

mkdir -p $ANDROID_HOME/cmdline-tools/latest
wget https://dl.google.com/android/repository/commandlinetools-linux-9123335_latest.zip -O cmdline-tools.zip > /dev/null 2>&1
unzip cmdline-tools.zip
mv cmdline-tools/* $ANDROID_HOME/cmdline-tools/latest
rm -rf cmdline-tools*

source /etc/profile

yes | sdkmanager --install "platform-tools" "platforms;android-33" "build-tools;33.0.0" "sources;android-33" "system-images;android-33;android-desktop;x86_64" "emulator"

echo "[CONFIGURADO] - Android"

# Criar emulador 
# avdmanager create avd -n google9 -k "system-images;android-33;android-desktop;x86_64" -d "Nexus 9"
# avdmanager create avd -n Pixel6 -k "system-images;android-33;android-desktop;x86_64" -d "pixel_6"
# Listar devices disponiveis
# avdmanager list devices


# lsof /dev/kvm
# sudo service libvirtd restart


# Executar no diretorio do emulador
# Listar imagens
# ./emulator -list-avds
# Rodar o emulador
# ./emulator -avd Pixel_6_API_33
