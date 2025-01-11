#!/usr/bin/env bash

start_time=$(date +%s)

echo "INICIANDO INSTALAÇÃO E CONFIGURAÇÃO AUTOMATIZADA"

# Função para detectar a distribuição
detect_distro() {
    if [ -f /etc/debian_version ]; then
        echo "debian"
    elif [ -f /etc/arch-release ]; then
        echo "arch"
    else
        echo "unsupported"
    fi
}

DISTRO=$(detect_distro)

if [ "$DISTRO" = "unsupported" ]; then
    echo "Distribuição não suportada!"
    exit 1
fi

# Importar funções comuns
source "$(dirname "$0")/distros/common.sh"

# Importar funções específicas da distribuição
source "$(dirname "$0")/distros/$DISTRO.sh"

######### EXECUÇÃO DAS ETAPAS #########
update
add_repositories
install_packages
install_snaps
update
run_scripts
update
######### EXECUÇÃO DAS ETAPAS #########

end_time=$(date +%s)
total_time=$((end_time - start_time))
echo "Tempo de execução do script: $total_time segundos."
echo "AMBIENTE CONFIGURADO E INSTALADO COM SUCESSO!"
