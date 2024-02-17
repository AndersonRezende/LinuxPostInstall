#!/usr/bin/env bash

######### PERSONALIZAÇÕES E CONFIGURAÇÕES #########
######### CONFIGURANDO EXIBIÇÃO DO NOME DA BRANCH NO TERMINAL #########
#echo "parse_git_branch() {
#     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
#}" >> ~/.bashrc
#echo 'export PS1="\u@\h \[\e[94m\]\w \[\e[32m\]\$(parse_git_branch)\[\e[00m\]$ "
#' >> ~/.bashrc

#source ~/.bashrc
######### CONFIGURANDO EXIBIÇÃO DO NOME DA BRANCH NO TERMINAL #########
######### Linux mint -> sudo rm /etc/apt/preferences.d/nosnap.pref #########


######### CONFIGURAÇÃO DE PATH #########

echo "[CONFIGURANDO] - Variáveis de ambiente"
if [ ! $JAVA_HOME ] && [ ! $ANDROID_HOME ]; then
     USER_HOME=$HOME
     sudo tee -a /etc/profile << END
JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"
export JAVA_HOME
set PATH="\$PATH:\$JAVA_HOME/bin"

export ANDROID_HOME=$USER_HOME/Android/Sdk
export PATH=\$PATH:\$ANDROID_HOME/tools
export PATH=\$PATH:\$ANDROID_HOME/tools/latest/bin
export PATH=\$PATH:\$ANDROID_HOME/platform-tools
export PATH=\$PATH:\$ANDROID_HOME/cmdline-tools/latest/bin


export PATH=\$PATH:\$USER_HOME/scripts
END

sleep 2
source /etc/profile
fi
echo "[CONFIGURADO] - Variáveis de ambiente"
# Verificar o $HOME para apontar do usuário principal e nao do root
######### CONFIGURAÇÃO DE PATH #########


echo 'parse_git_branch() {
  git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/ (\1)/"
}

export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[93m\]\$(parse_git_branch)\[\033[00m\]$ "' >> ~/.bashrc

source ~/.bashrc
