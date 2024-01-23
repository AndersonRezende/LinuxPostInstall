#!/usr/bin/env bash
start_time=$(date +%s)

echo "INICIANDO INSTALAÇÃO E CONFIGURAÇÃO AUTOMATIZADA"

## Função para atualizar o sistema ##
update() {
    echo "[ATUALIZANDO O SISTEMA]"
    if ! sudo apt-get update -y > /dev/null 2>&1
    then
        echo "Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list"
        exit 1
    fi
    sudo apt upgrade -y > /dev/null 2>&1
    sudo apt autoclean -y > /dev/null 2>&1
    sudo apt autoremove -y > /dev/null 2>&1
    echo "[ATUALIZAÇÃO CONCLUIDA]"
}

## Função para executar scripts adicionais/específicos contidos na pasta scripts ##
# Para adicionar scripts personalizados é necessário: 
# 1 - Adicionar um arquivo com ".sh" no final do nome do arquivo no diretório /scripts
# 2 - Adicionar #!/bin/bash no topo do arquivo
run_scripts() {
    scripts=$(ls -1 scripts/*.sh | sort)
    for script in $scripts; do
        echo "[EXECUTANDO] - $script"
        sudo chmod +x $script
        sudo sh $script
    done
}

## Função para verificar se um software está instalado ##
# @param - Nome do software
# @return - Retorna 0 caso esteja instalado ou 1 caso não esteja instalado
is_installed() {
    local software="$1"
    if command -v "$software" > /dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

## Função para instalar os snaps contidos no arquivo snaps.txt ##
install_snaps() {
    if [ -f "snaps.txt" ]; then
        while IFS= read -r snap || [[ -n "$snap" ]]; do
            # Ignorar linha em branco ou que começam com #
            if [[ -n "$snap" && "$snap" != "#"* ]]; then
                if is_installed $snap; then # Só instala se não estiver instalado
                    echo "[INSTALADO] - $snap"
                else
                    echo "Instalando o pacote: $snap"
                    sudo apt install -y $snap > /dev/null 2>&1
                    if is_installed $snap; then
                        echo "[INSTALADO] - $snap"
                    fi
                fi
            fi
        done < "snaps.txt"
    else
        echo "Arquivo packages.txt não encontrado!"
    fi
}

## Função para instalar os pacotes contidos no arquivo packages.txt ##
install_packages() {
    if [ -f "packages.txt" ]; then
        while IFS= read -r package || [[ -n "$package" ]]; do
            # Ignorar linha em branco ou que começam com #
            if [[ -n "$package" && "$package" != "#"* ]]; then
                if is_installed $package; then # Só instala se não estiver instalado
                    echo "[INSTALADO] - $package"
                else
                    echo "Instalando o pacote: $package"
                    sudo apt install -y $package > /dev/null 2>&1
                    if is_installed $package; then
                        echo "[INSTALADO] - $package"
                    fi
                fi
            fi
        done < "packages.txt"
    else
        echo "Arquivo packages.txt não encontrado!"
    fi
}

## Função para adicionar repositorios contidos no arquivo repositories.txt ##
add_repositories() {
    if [ -f "repositories.txt" ]; then
        while IFS= read -r repository || [[ -n "$repository" ]]; do
            # Ignorar linha em branco ou que começam com #
            if [[ -n "$repository" && "$repository" != "#"* ]]; then
                echo "Adicionando o repositório: $repository"
                if sudo add-apt-repository -y "$repository" > /dev/null 2>&1; then
                    echo "O repositório $repository foi adicionado com sucesso."
                else
                    echo "Falha ao adicionar o repositório $repository."
                fi
            fi
        done < "repositories.txt"
    else
        echo "Arquivo repositories.txt não encontrado!"
    fi
}

######### ATUALIZAÇÃO DO SISTEMA #########
update

######### ADIÇÃO DE REPOSITÓRIOS #########
add_repositories

######### INSTALAÇÃO DOS PACOTES #########
install_packages

######### INSTALAÇÃO DOS SNAPS #########
install_snaps

######### EXECUÇÃO DOS SCRIPTS #########
run_scripts

######### ATUALIZAÇÃO DO SISTEMA #########
update

end_time=$(date +%s)
total_time=$((end_time - start_time))
echo "Tempo de execução do script: $total_time segundos."
echo "AMBIENTE CONFIGURADO E INSTALADO COM SUCESSO!"