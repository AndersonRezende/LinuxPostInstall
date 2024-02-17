#!/usr/bin/env bash

######### PARTIÇÃO DE ARQUIVOS #########
echo "[CONFIGURANDO] - Montagem da partição de Arquivos"
DEVICE=/dev/nvme0n1p1
MOUNT_DIR=/mnt/Arquivos
echo "$DEVICE $MOUNT_DIR auto nosuid,nodev,nofail,x-gvfs-show,x-gvfs-name=Arquivos 0 0" | sudo tee -a /etc/fstab
echo "[CONFIGURANDO] - Montagem da partição de Arquivos"
######### PARTIÇÃO DE ARQUIVOS #########