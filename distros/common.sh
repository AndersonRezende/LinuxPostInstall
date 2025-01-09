#!/usr/bin/env bash

# Função para verificar se um software está instalado
is_installed() {
    local software="$1"
    if command -v "$software" > /dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

# Função para executar scripts personalizados
run_scripts() {
    scripts=$(ls -1 "$(dirname "$0")/scripts/$DISTRO/"*.sh 2>/dev/null | sort)
    for script in $scripts; do
        echo "[EXECUTANDO] - $script"
        sudo chmod +x "$script"
        ./"$script"
        echo "[FINALIZADO] - $script"
    done
}

# Função para instalar os snaps contidos no arquivo snaps.txt
install_snaps() {
    echo "[VERIFICANDO SUPORTE A SNAPS NO SISTEMA]"

    # Configurar snapd para diferentes distribuições
    if ! is_installed snap; then
        if [ -f /etc/debian_version ]; then
            echo "Instalando snapd no Debian/Ubuntu..."
            sudo apt update -y > /dev/null 2>&1
            sudo apt install -y snapd > /dev/null 2>&1
        elif [ -f /etc/arch-release ]; then
            echo "Instalando snapd no Arch Linux..."
            sudo pacman -S --noconfirm snapd > /dev/null 2>&1
            echo "Habilitando snapd.socket..."
            sudo systemctl enable --now snapd.socket > /dev/null 2>&1
            echo "Criando link simbólico para /snap..."
            sudo ln -s /var/lib/snapd/snap /snap > /dev/null 2>&1
        elif [ -f /etc/redhat-release ]; then
            echo "Instalando snapd no Red Hat/CentOS..."
            sudo yum install -y epel-release > /dev/null 2>&1
            sudo yum install -y snapd > /dev/null 2>&1
            sudo systemctl enable --now snapd.socket > /dev/null 2>&1
            echo "Criando link simbólico para /snap..."
            sudo ln -s /var/lib/snapd/snap /snap > /dev/null 2>&1
        elif [ -f /etc/alpine-release ]; then
            echo "Snap não é suportado no Alpine Linux diretamente. Ignorando..."
            return
        else
            echo "Distribuição não suportada para Snap. Ignorando..."
            return
        fi
    fi

    local snaps_file=$(pwd)"/packages/snaps.txt"
    if [ -f "$snaps_file" ]; then
        while IFS= read -r snapline || [[ -n "$snapline" ]]; do
            IFS=' ' read -r snap parameter <<< "$snapline"
            if [[ -n "$snap" && "$snap" != "#"* ]]; then
                if is_installed $snap $parameter; then
                    echo "[INSTALADO] - $snap"
                else
                    echo "Instalando snap: $snap"
                    sudo snap install $snap $parameter> /dev/null 2>&1
                    if is_installed $snap; then
                        echo "[INSTALADO] - $snap"
                    else
                        echo "Falha ao instalar o snap: $snap"
                    fi
                fi
            fi
        done < "$snaps_file"
    else
        echo "Arquivo $snaps_file não encontrado!"
    fi
}
