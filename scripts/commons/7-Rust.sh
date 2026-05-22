#!/usr/bin/env bash

echo -n "Instalando RUST"
sleep 1
if command -v rustup > /dev/null 2>&1; then
	echo -e "\r[INSTALANDO] - Rust"
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
	echo -e "\r[INSTALADO] - Rust"
fi