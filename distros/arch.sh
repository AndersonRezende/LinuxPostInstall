#!/usr/bin/env bash

# Função para atualizar o sistema
update() {
    echo "[ATUALIZANDO O SISTEMA - Arch]"
    sudo pacman -Syu --noconfirm > /dev/null 2>&1
    echo "[ATUALIZAÇÃO CONCLUÍDA]"
}

# Função para instalar pacotes
install_packages() {
    echo "[INSTALANDO PACOTES - Arch]"
    local packages_file=$(pwd)"/packages/packages_arch.txt"
    if [ -f "$packages_file" ]; then
        while IFS= read -r package || [[ -n "$package" ]]; do
            if [[ -n "$package" && "$package" != "#"* ]]; then
                if is_installed "$package"; then
                    echo "[INSTALADO] - $package"
                else
                    echo "Instalando o pacote $package"
                    sudo pacman -S --noconfirm "$package" > /dev/null 2>&1
                fi
            fi
        done < "$packages_file"
    else
        echo "Arquivo $packages_file não encontrado!"
    fi
}

# Função para adicionar repositórios
add_repositories() {
    echo "[ATUALIZANDO OS REPOSITÓRIOS DO SISTEMA - Arch]"
    sudo pacman-mirrors -f5  > /dev/null 2>&1 && sudo pacman -Syyu --noconfirm > /dev/null 2>&1
    sudo sed -Ei '/EnableAUR/s/^#//' /etc/pamac.conf
    sudo sed -Ei '/CheckAURUpdates/s/^#//' /etc/pamac.conf
    echo "[ATUALIZAÇÃO CONCLUÍDA]"
}
