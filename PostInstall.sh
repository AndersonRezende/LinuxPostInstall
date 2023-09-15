#!/bin/bash
inicio=$(date +%s)

echo "INICIANDO INSTALAÇÃO E CONFIGURAÇÃO AUTOMATIZADA"
######### Linux mint -> sudo rm /etc/apt/preferences.d/nosnap.pref #########

DOWNLOAD_FILES_DIR=~/Downloads/install
if [ -d "$DOWNLOAD_FILES_DIR" ]; then 
    sudo rm -Rf $DOWNLOAD_FILES_DIR/*; 
else
    sudo mkdir $DOWNLOAD_FILES_DIR
    sudo chmod -R 777 $DOWNLOAD_FILES_DIR
fi
cd $DOWNLOAD_FILES_DIR


SOFTWARE_INSTALL_LIST=(
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

SNAP_SOFTWARES_LIST=(
    dbeaver-ce
    spotify
    sublime-text
)


if ! sudo apt-get update
then
    echo "Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list"
    exit 1
fi
sudo apt -y upgrade



######### REPOSITORY LIST #########
sudo add-apt-repository ppa:openjdk-r/ppa -y
######### REPOSITORY LIST #########


######### APT LIST #########
for nome_do_programa in ${SOFTWARE_INSTALL_LIST[@]}; do
    if which $nome_do_programa > /dev/null; then # Só instala se já não estiver instalado
        echo "[INSTALADO] - $nome_do_programa"
    else
        sudo apt install "$nome_do_programa" -y
    fi
done
######### APT LIST #########


######### SNAP LIST #########
for nome_do_programa in ${SNAP_SOFTWARES_LIST[@]}; do
    if which $nome_do_programa > /dev/null; then # Só instala se já não estiver instalado
        echo "[INSTALADO] - $nome_do_programa"
    else
        sudo snap install "$nome_do_programa"
    fi
done
######### SNAP LIST #########


######### GOOGLE CHROME #########
if dpkg -l | grep -q "chrome"; then
    echo "O Google Chrome já está instalado."
else
    echo "Inciando instalação do Google Chrome."
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O $DOWNLOAD_FILES_DIR/chrome.deb
    sudo dpkg -i $DOWNLOAD_FILES_DIR/chrome.deb
fi
######### GOOGLE CHROME #########


######### APACHE #########
    #sudo apt install -y apache2
sudo ufw app list
sudo ufw allow in "Apache"
sudo systemctl restart apache2
response=$(curl --write-out '%{http_code}' --silent --output /dev/null http://localhost)
if [[ "$response" -ne 200 ]]
then
    echo "Houve um erro ao instalar o apache"
    exit 1
fi


######### MYSQL #########
    #sudo apt-get install mysql-server mysql-client
    #sudo a2enmod rewrite
    #sudo apt install mysql-server
PASSWORD='root'
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$PASSWORD';"
sudo mysql -p"$PASSWORD" -e "flush privileges;"
    #sudo mysql
    #echo "Digite os seguintes comandos no terminal"
    #echo "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';"
    #echo "flush privileges;"
    #ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
    #flush privileges;
    #exit
    #sudo mysql_secure_installation
    # Defina as variáveis para preencher automaticamente as respostas. COLOQUE 'y' para sim ou 'n'
    #MYSQL_ROOT_PASSWORD="root"
    #VALIDATE_PASSWORD_COMPONENT="n"
    #CHANGE_ROOT_PASSWORD="n"
    #REMOVE_ANONYMOUS_USERS="n"  # Responda 'y' para remover usuários anônimos
    #DISALLOW_ROOT_LOGIN="n"     # Responda 'y' para desativar login de root remotamente
    #REMOVE_TEST_DATABASE="n"    # Responda 'y' para remover o banco de dados de teste
    #RELOAD_PRIVILEGE_TABLES="y" # Responda 'y' para recarregar tabelas de privilégio

    # Execute o comando mysql_secure_installation com as respostas automáticas
    #echo "Preenchendo automaticamente as respostas para mysql_secure_installation..."
    #echo "$MYSQL_ROOT_PASSWORD" > /tmp/mysql_secure_installation_input
    #echo "$VALIDATE_PASSWORD_COMPONENT" > /tmp/mysql_secure_installation_input
    #echo "$CHANGE_ROOT_PASSWORD" > /tmp/mysql_secure_installation_input
    #echo "$REMOVE_ANONYMOUS_USERS" >> /tmp/mysql_secure_installation_input
    #echo "$DISALLOW_ROOT_LOGIN" >> /tmp/mysql_secure_installation_input
    #echo "$REMOVE_TEST_DATABASE" >> /tmp/mysql_secure_installation_input
    #echo "$RELOAD_PRIVILEGE_TABLES" >> /tmp/mysql_secure_installation_input

    #sudo mysql_secure_installation < /tmp/mysql_secure_installation_input

    # Remova o arquivo de entrada temporária
    #rm /tmp/mysql_secure_installation_input
######### MYSQL #########


######### PHP #########
    #sudo apt install php libapache2-mod-php php-mysql
    #sudo apt install -y php-{common,mysql,xml,xmlrpc,curl,gd,imagick,cli,dev,imap,mbstring,opcache,soap,zip,intl}      #libs laravel
    #sudo apt install -y composer
    #curl -sS https://getcomposer.org/installer | php
    #sudo mv composer.phar /usr/local/bin/composer
    #sudo chmod +x /usr/local/bin/composer
#sudo systemctl restart apache2
#php -v
#sudo echo "<?php phpinfo();" >> /var/www/html/info.php
#firefox http://localhost/info.php
######### PHP #########


######### JAVA #########
    #sudo add-apt-repository ppa:openjdk-r/ppa -y
    #apt search openjdk
    #sudo apt install default-jdk -y
    #sudo apt install default-jre -y

#Configuração do JAVA HOME
javahome=$(cat /etc/environment | grep -c "JAVA_HOME")
if [ $javahome -eq 0 ]; then
    echo "Configurando o JAVA_HOME"

    #Armazena output do comando na variável
    resultado=$(update-alternatives --config java)
    # Strings para determinar o começo e final da string
    inicio="/usr/lib"
    fim="bin/java"

    pos_inicial=$(echo "$resultado" | grep -b -o "$inicio" | cut -d':' -f1)-2

    # Verificar se a string de início foi encontrada
    if [[ -n "$pos_inicial" ]]; then
        # Extrair a parte do resultado a partir da posição inicial
        parte="${resultado:$pos_inicial}"

        # Encontrar a posição final da string no resultado
        pos_final=$(echo "$parte" | grep -b -o "$fim" | cut -d':' -f1)

        # Verificar se a string de fim foi encontrada
        if [[ -n "$pos_final" ]]; then
            # Extrair a parte do resultado até a posição final
            parte="${parte:0:$pos_final}"
        else
            echo "Não foi possível configurar o JAVA_HOME."
        fi

        # Imprimir a parte capturada
        echo "$parte"
    else
        echo "Não foi possível configurar o JAVA_HOME."
    fi
else
    echo "O JAVA_HOME já foi definido."
fi



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
    #sudo tar vzxf $chave.tar.gz -C /opt/
    #sudo mkdir /opt/$chave && sudo tar vzxf phpstorm.tar.gz -C /opt/$chave 
    
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



######### INSTALL ARDUINO #########
    #sudo add-apt-repository universe
    #sudo apt install libfuse2
    #wget https://downloads.arduino.cc/arduino-ide/nightly/arduino-ide_nightly-20230913_Linux_64bit.AppImage -O $DOWNLOAD_FILES_DIR/arduino.AppImage
    #sudo chmod ugo+x $DOWNLOAD_FILES_DIR/arduino.AppImage
    #sudo cp  $DOWNLOAD_FILES_DIR/arduino.AppImage /usr/bin


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




# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Finalização, atualização e limpeza##
sudo apt update && sudo apt dist-upgrade -y
flatpak update
sudo apt autoclean
sudo apt autoremove -y
# ---------------------------------------------------------------------- #

fim=$(date +%s)
tempo_decorrido=$((fim - inicio))
echo "Tempo de execução do script: $tempo_decorrido segundos."
echo "FINALIZADA A INSTALAÇÃO E CONFIGURAÇÃO AUTOMATIZADA!"