#!/usr/bin/env bash

echo "Instalando RUST"

if command -v rustup > /dev/null 2>&1; then
	echo "[INSTANLADO] - Rust"
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
	echo "[INSTALADO] - Rust"
fi