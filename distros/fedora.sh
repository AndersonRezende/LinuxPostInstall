#!/usr/bin/env bash

# Função para atualizar o sistema
update() {
    echo "[ATUALIZANDO O SISTEMA - Fedora]"
    sudo dnf update -y > /dev/null 2>&1
    sudo dnf upgrade -y > /dev/null 2>&1
    sudo dnf autoremove -y > /dev/null 2>&1
    echo "[ATUALIZAÇÃO CONCLUÍDA]"
}

# Função para instalar pacotes
install_packages() {
    local packages_file=$(pwd)"/packages/packages_fedora.txt"
    
    if [ -f "$packages_file" ]; then
        while IFS= read -r package || [[ -n "$package" ]]; do
            if [[ -n "$package" && "$package" != "#"* ]]; then
                sudo dnf install -y "$package" > /dev/null 2>&1
            fi
        done < "$packages_file"
    fi
}

# Função para adicionar repositórios
add_repositories() {
    echo "Adicionando o repositório: Visual Studio Code"
    sudo rpm --import "$repository" > /dev/null 2>&1
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo
}