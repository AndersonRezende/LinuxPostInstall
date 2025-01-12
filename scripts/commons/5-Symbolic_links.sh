#!/usr/bin/env bash

######### PARTIÇÃO DE ARQUIVOS #########
echo "[CONFIGURANDO] - Criação de links simbólicos"
ln -s /mnt/Arquivos/Documentos /home/$USER/Documentos
ln -s /mnt/Arquivos/Músicas /home/$USER/Música
ln -s /mnt/Arquivos/Vídeos /home/$USER/Vídeos
ln -s /mnt/Arquivos/Imagens /home/$USER/Imagens
ln -s /mnt/Arquivos/Downloads /home/$USER/Downloads
ln -s /mnt/Arquivos/Documentos/Projetos /home/$USER/Projetos
echo "[CONFIGURANDO] - Criação de links simbólicos"
######### PARTIÇÃO DE ARQUIVOS #########