#!/usr/bin/env bash

######### PARTIÇÃO DE ARQUIVOS #########
echo "[CONFIGURANDO] - Montagem da partição de Arquivos"
MOUNT_DIR=/mnt/Arquivos
LABEL=ARQUIVOS
echo "LABEL=$LABEL $MOUNT_DIR auto nosuid,nodev,nofail,x-gvfs-show,x-gvfs-name=Arquivos 0 0" | sudo tee -a /etc/fstab
echo "[CONFIGURADO] - Montagem da partição de Arquivos"
######### PARTIÇÃO DE ARQUIVOS #########