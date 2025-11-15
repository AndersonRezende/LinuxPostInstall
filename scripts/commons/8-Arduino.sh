#!/usr/bin/env bash

echo "Instalando ARDUINO"

if command -v arduino > /dev/null 2>&1; then
	echo "[INSTALANDO] - Arduino"
	wget https://downloads.arduino.cc/arduino-ide/arduino-ide_2.3.6_Linux_64bit.zip -O arduino.zip > /dev/null 2>&1
	unzip arduino.zip > /dev/null 2>&1
	sudo mv arduino/arduino-ide_2.3.6_Linux_64bit /opt/arduino 2>&1
	sudo ln -s /opt/arduino/arduino-ide /usr/local/bin/arduino 2>&1
	rm -rf arduino.zip arduino 2>&1
	echo "[INSTALADO] - Arduino"
else
	echo "[INSTALADO] - Arduino"
fi