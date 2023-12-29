# LinuxPostInstall
### Objetivo
Automatizar o processo de instalação e configuração de softwares após uma nova instalação de um ambiente Linux baseado em **Debian** (debian, ubuntu, mint...).
### Executar
```
sudo chmod +x PostInstall.sh
sudo ./ PostInstall.sh
```

### Personalizar instalação
1. Para modificar os pacotes, snaps e/ou repositórios basta:
    1. Abrir o arquivo equivalente para cada um dos itens.
        - Pacotes: **packages.txt**
        - Snaps: **snaps.txt**
        - Repositório: **repositories.txt**
    1. Para adicionar um item basta apenas dar uma quebra de linha e colocar o nome do pacote, snap ou repositório desejado.
    1. Para remover um item é necessário apenas apagar a linha que contém o item que desejar que não seja instalado.
1. Para adição/remoção de scripts de configuração é necessário:
    1. Abrir o diretório scripts;
    1. Adicionar um arquivo cujo o nome finalize com .sh ou deletar o arquivo contendo o script não desejado.
