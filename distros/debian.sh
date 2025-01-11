#!/usr/bin/env bash

# Função para atualizar o sistema
update() {
    echo "[ATUALIZANDO O SISTEMA - Debian]"
    sudo apt-get update -y > /dev/null 2>&1
    sudo apt-get upgrade -y > /dev/null 2>&1
    sudo apt-get autoclean -y > /dev/null 2>&1
    sudo apt-get autoremove -y > /dev/null 2>&1
    echo "[ATUALIZAÇÃO CONCLUÍDA]"
}

# Função para instalar pacotes
install_packages() {
    local packages_file=$(pwd)"/packages/packages_debian.txt"
    
    if [ -f "$packages_file" ]; then
        while IFS= read -r package || [[ -n "$package" ]]; do
            if [[ -n "$package" && "$package" != "#"* ]]; then
                sudo apt-get install -y "$package" > /dev/null 2>&1
            fi
        done < "$packages_file"
    fi
}

# Função para adicionar repositórios
add_repositories() {
    local repositories_file="../packages/repositories.txt"
    if [ -f "$repositories_file" ]; then
        while IFS= read -r repository || [[ -n "$repository" ]]; do
            if [[ -n "$repository" && "$repository" != "#"* ]]; then
                echo "Adicionando o repositório: $repository"
                sudo add-apt-repository -y "$repository" > /dev/null 2>&1
            fi
        done < "$repositories_file"
    fi
}