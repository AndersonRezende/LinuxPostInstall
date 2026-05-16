#!/usr/bin/env bash

######### PARTIÇÃO DE ARQUIVOS #########
echo "[CONFIGURANDO] - Montagem da partição de Arquivos"
MOUNT_DIR=/mnt/Arquivos
LABEL=ARQUIVOS
if grep -qE "^LABEL=$LABEL\b" /etc/fstab; then
  echo "[PULAR] - LABEL=$LABEL já existe em /etc/fstab"
else
  echo "LABEL=$LABEL $MOUNT_DIR auto nosuid,nodev,nofail,x-gvfs-show,x-gvfs-name=Arquivos 0 0" | sudo tee -a /etc/fstab
fi
echo "[CONFIGURADO] - Montagem da partição de Arquivos"
######### PARTIÇÃO DE ARQUIVOS #########