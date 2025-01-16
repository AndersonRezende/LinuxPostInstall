# LinuxPostInstall
### Objetivo
Automatizar o processo de instalação e configuração de softwares após uma nova instalação de um ambiente Linux baseado em **Debian** (Debian, Ubuntu, Mint, etc) e **Arch** (Arch, Manjaro, etc).
### Executar
```
sudo chmod +x PostInstall.sh
./PostInstall.sh
```

### Personalizar instalação
1. Para modificar os pacotes, snaps e/ou repositórios basta:
    1. Abrir o arquivo equivalente para cada um dos itens e com o sufixo da distro base.
        - Pacotes: **packages_DISTRO.txt**
        - Snaps: **snaps_DISTRO.txt**
        - Repositório: **repositories.txt**
    1. Para adicionar um item basta apenas dar uma quebra de linha e colocar o nome do pacote, snap ou repositório desejado.
    1. Para remover um item é necessário apenas apagar a linha que contém o item que desejar que não seja instalado.
1. Para adição/remoção de scripts de configuração é necessário:
    1. Abrir o diretório scripts;
    1. Abrir o diretório correspondente a distribuição Linux desejada ou no commons para o caso de um script genérico para ambas as distribuições;
    1. Adicionar um arquivo cujo o nome finalize com .sh ou deletar o arquivo contendo o script não desejado.
