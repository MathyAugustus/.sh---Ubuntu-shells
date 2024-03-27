#!/bin/bash

# Verifica se o arquivo /var/lib/apt/lists/lock existe
if [ -e /var/lib/apt/lists/lock ]; then
    # Pergunta ao usuário se deseja apagar o arquivo
    read -p "O arquivo /var/lib/apt/lists/lock existe. Deseja apagá-lo? (Y/n): " resposta

    # Verifica a resposta do usuário
    if [ "$resposta" == "Y" ]; then
        # Remove o arquivo se a resposta for 'y'
        sudo rm /var/lib/apt/lists/lock
        echo "O arquivo /var/lib/apt/lists/lock foi removido."
    else
        echo "Nenhuma ação foi realizada. O arquivo /var/lib/apt/lists/lock não foi removido."
    fi
else
    echo "O arquivo /var/lib/apt/lists/lock não existe. Nenhuma ação foi realizada."
fi

# Atualizar os pacotes do sistema
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt clean

# Atualizar os pacotes Snap
sudo snap refresh

# Atualizar os programas instalados via repositórios do Ubuntu
sudo apt dist-upgrade -y

# Lembrete para reiniciar (opcional)
#echo "Lembre-se de reiniciar o sistema, se necessário."
read -p "Digite Y para reiniciar..." opt
if [ "$opt" == "Y" ]
then
    echo "Reiniciando ... "
    sudo reboot
else
    echo "Saindo sem reiniciar!!"
fi
