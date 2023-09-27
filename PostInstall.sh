#!/bin/bash
start_time=$(date +%s)

echo "INICIANDO INSTALAÇÃO E CONFIGURAÇÃO AUTOMATIZADA"

# Configurando um diretório de trabalho
DOWNLOAD_FILES_DIR=~/Downloads/install
if [ -d "$DOWNLOAD_FILES_DIR" ]; then 
    sudo rm -Rf $DOWNLOAD_FILES_DIR/*; 
else
    sudo mkdir $DOWNLOAD_FILES_DIR
    sudo chmod -R 777 $DOWNLOAD_FILES_DIR
fi
cd $DOWNLOAD_FILES_DIR

# Lista de pacotes apt que devem ser instalados
APT_SOFTWARES_LIST=(
    snapd
    virtualbox
    telegram-desktop
    gparted
    curl

    apache2
    mysql-server

    php libapache2-mod-php php-mysql
    php-{common,mysql,xml,xmlrpc,curl,gd,imagick,cli,dev,imap,mbstring,opcache,soap,zip,intl}
    composer

    default-jdk
    default-jre

    nodejs
    npm
)

# Lista de snaps que devem ser instalados
SNAP_SOFTWARES_LIST=(
    dbeaver-ce
    postman
    spotify
    sublime-text
    whatsapp-for-linux
)

# Tenta atualizar o sistema
if ! sudo apt-get update
then
    echo "Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list"
    exit 1
fi
sudo apt -y upgrade



######### REPOSITORY LIST #########
sudo add-apt-repository ppa:openjdk-r/ppa -y
######### REPOSITORY LIST #########


# Instalação dos pacotes apt
######### APT LIST #########
for software_name in ${APT_SOFTWARES_LIST[@]}; do
    if which $software_name > /dev/null; then # Só instala se já não estiver instalado
        echo "[INSTALADO] - $software_name"
    else
        sudo apt install "$software_name" -y
    fi
done
######### APT LIST #########


# Instalação dos snaps
######### SNAP LIST #########
for software_name in ${SNAP_SOFTWARES_LIST[@]}; do
    if which $software_name > /dev/null; then # Só instala se já não estiver instalado
        echo "[INSTALADO] - $software_name"
    else
        sudo snap install "$software_name"
    fi
done
######### SNAP LIST #########


# Instalação do Chrome
######### GOOGLE CHROME #########
if dpkg -l | grep -q "chrome"; then
    echo "O Google Chrome já está instalado."
else
    echo "Inciando instalação do Google Chrome."
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O $DOWNLOAD_FILES_DIR/chrome.deb
    sudo dpkg -i $DOWNLOAD_FILES_DIR/chrome.deb
fi
######### GOOGLE CHROME #########


# Configuração do apache
######### APACHE #########
sudo ufw app list
sudo ufw allow in "Apache"
sudo systemctl restart apache2
response=$(curl --write-out '%{http_code}' --silent --output /dev/null http://localhost)
if [[ "$response" -ne 200 ]]
then
    echo "Houve um erro ao instalar o apache"
    exit 1
fi
######### APACHE #########


# Configuração do MySql
######### MYSQL #########
PASSWORD='root'
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$PASSWORD';"
sudo mysql -p"$PASSWORD" -e "flush privileges;"
######### MYSQL #########


# Configuração de algumas IDE`s
######### INSTALL JETBRAINS IDE'S #########
declare -A IDE_LIST_INSTALL
IDE_LIST_INSTALL[phpstorm]="https://download.jetbrains.com/webide/PhpStorm-2023.2.1.tar.gz?_ga=2.133236622.1667873579.1694237467-1335940619.1694237467&_gl=1*9hgx8r*_ga*MTMzNTk0MDYxOS4xNjk0MjM3NDY3*_ga_9J976DJZ68*MTY5NDI4NjkzOS4yLjEuMTY5NDI4Njk3NC4wLjAuMA.."
IDE_LIST_INSTALL[pycharm]="https://download.jetbrains.com/python/pycharm-professional-2023.2.1.tar.gz?_ga=2.140659506.1667873579.1694237467-1335940619.1694237467&_gl=1*1i5vdc3*_ga*MTMzNTk0MDYxOS4xNjk0MjM3NDY3*_ga_9J976DJZ68*MTY5NDI4NjkzOS4yLjEuMTY5NDI4NzA3NS4wLjAuMA.."
IDE_LIST_INSTALL[idea]="https://download.jetbrains.com/idea/ideaIU-2023.2.1.tar.gz?_ga=2.124912522.1667873579.1694237467-1335940619.1694237467&_gl=1*1wyu6i0*_ga*MTMzNTk0MDYxOS4xNjk0MjM3NDY3*_ga_9J976DJZ68*MTY5NDI4NjkzOS4yLjEuMTY5NDI4NzE2OS4wLjAuMA.."
IDE_LIST_INSTALL[webstorm]="https://download.jetbrains.com/webstorm/WebStorm-2023.2.1.tar.gz?_ga=2.124912522.1667873579.1694237467-1335940619.1694237467&_gl=1*1akza89*_ga*MTMzNTk0MDYxOS4xNjk0MjM3NDY3*_ga_9J976DJZ68*MTY5NDI4NjkzOS4yLjEuMTY5NDI4NzE4Ny4wLjAuMA.."

TEMP_EXTRACT_DIR=$DOWNLOAD_FILES_DIR/temp
if [ -d "$TEMP_EXTRACT_DIR" ]; then 
    sudo rm -Rf $TEMP_EXTRACT_DIR/*; 
else
    sudo mkdir $TEMP_EXTRACT_DIR
    sudo chmod -R 777 $TEMP_EXTRACT_DIR
fi
for chave in "${!IDE_LIST_INSTALL[@]}"; do
    valor="${IDE_LIST_INSTALL[$chave]}"
    echo "Instalando $chave"

    # Download do arquivo
    wget $valor -O $DOWNLOAD_FILES_DIR/$chave.tar.gz
    sleep 2
    # Remove instalações antigas
    sudo rm -Rf /opt/$chave*
    sudo rm -Rf /usr/bin/$chave
    sudo rm -Rf /usr/share/applications/$chave.desktop

    # Descompacta arquivo e move para opt
    sudo tar vzxf $chave.tar.gz -C $TEMP_EXTRACT_DIR
    sudo mv $TEMP_EXTRACT_DIR/* /opt/$chave

    # Criar atalho e lançador de programa
    sudo ln -sf /opt/$chave/bin/$chave.sh /usr/bin/$chave
    echo -e "[Desktop Entry]\n Version=1.0\n Name=$chave\n Exec=/opt/$chave/bin/$chave.sh\n Icon=/opt/$chave/bin/$chave.png\n Type=Application\n Categories=Development" | sudo tee /usr/share/applications/$chave.desktop
    sudo chmod +x /usr/share/applications/$chave.desktop
    if [ "${LANG%.*}" = "pt" ]; then
        sudo cp /usr/share/applications/$chave.desktop  ~/Área\ de\ Trabalho/
    elif [ "${LANG%.*}" = "en" ]; then
        cp /usr/share/applications/$chave.desktop ~/Desktop
    else
        echo "Atalho no desktop não foi criado."
    fi
    #sudo rm -rf $DOWNLOAD_FILES_DIR/*
    # Limpa o diretório temporário
    sudo rm -Rf $TEMP_EXTRACT_DIR/*;
done
######### INSTALL JETBRAINS IDE'S #########



# Instalação e configuração da IDE do arduino
######### INSTALL ARDUINO #########
wget https://downloads.arduino.cc/arduino-1.8.16-linux64.tar.xz -O arduino.tar.xz
sudo tar xvf $DOWNLOAD_FILES_DIR/arduino.tar.xz -C $TEMP_EXTRACT_DIR
sudo mv $TEMP_EXTRACT_DIR/* /opt/arduino
sudo sh /opt/arduino/install.sh
sudo rm -Rf $TEMP_EXTRACT_DIR/*;
######### INSTALL ARDUINO #########



######### PERSONALIZAÇÕES E CONFIGURAÇÕES #########
######### CONFIGURANDO EXIBIÇÃO DO NOME DA BRANCH NO TERMINAL #########
echo "parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}" >> ~/.bashrc
echo 'export PS1="\u@\h \[\e[94m\]\w \[\e[32m\]\$(parse_git_branch)\[\e[00m\]$ "
' >> ~/.bashrc

source ~/.bashrc
######### CONFIGURANDO EXIBIÇÃO DO NOME DA BRANCH NO TERMINAL #########
######### Linux mint -> sudo rm /etc/apt/preferences.d/nosnap.pref #########



# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Finalização, atualização e limpeza##
sudo apt update && sudo apt dist-upgrade -y
flatpak update
sudo apt autoclean
sudo apt autoremove -y
# ---------------------------------------------------------------------- #

end_time=$(date +%s)
total_time=$((end_time - start_time))
echo "Tempo de execução do script: $total_time segundos."
echo "AMBIENTE CONFIGURADO E INSTALADO COM SUCESSO!"