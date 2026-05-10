#!/usr/bin/env bash

get_current_de() {
	echo $XDG_CURRENT_DESKTOP
}

is_usb_keyboard_connected() {
	if lsusb | grep -E "Microdia USB Keyboard" > /dev/null; then
		return 1
	else
		return 0
	fi
}

if [[ "$(get_current_de | tr '[:upper:]' '[:lower:]')" != *kde* ]]; then
	echo "Ignorando: ambiente de desktop não é KDE."
	exit 0
fi

if is_usb_keyboard_connected; then
	echo "Aplicando o layout en int alt."
	qdbus org.kde.keyboard /Layouts setLayout 0 > /dev/null #en int alt.
else
	echo "Aplicando o layout pt BR."
	qdbus org.kde.keyboard /Layouts setLayout 1 > /dev/null #pt BR	
fi

#busctl --user call org.kde.keyboard /Layouts org.kde.KeyboardLayouts switchToNextLayout
#qdbus org.kde.keyboard /Layouts setLayout 0 #en int alt.
#qdbus org.kde.keyboard /Layouts setLayout 1 #pt BR
