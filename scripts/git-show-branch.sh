#!/bin/bash

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