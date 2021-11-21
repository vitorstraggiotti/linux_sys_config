#!/bin/bash

## System config ##

# Redução no uso de arquivos de paginação (swap)
echo 'vm.swappiness = 0' >> /etc/sysctl.conf
sysctl -p

## Udate and install programs ##

# Atualização do sistema
apt update
apt upgrade -y
apt autoremove -y

# Instalar compiladores, debugers e bibliotecas para programação C/C++
apt install build-essential -y

# Instalar GIT
apt install git -y

# Instalar media player
apt install vlc -y

# Instalar captura de tela
apt install simplescreenrecoreder -y

# Instalar editor de texto, slides ...
apt install libreoffice -y

# Instalar transcodificador de video
add-apt-repository ppa:stebbins/handbrake-releases
apt-get update
apt-get install handbrake-gtk -y

# Instalar comparador de arquivos
apt install meld -y

# Instalar conversor de imagens
apt install converseen -y

# Instalar gerenciador de ppa
add-apt-repository ppa:webupd8team/y-ppa-manager
apt update
apt install y-ppa-manager

# Instalar instalador de pacotes .deb
apt install gdebi

# Instalar criador de thumbnails para navegador de arquivos
apt install ffmpegthumbnailer
