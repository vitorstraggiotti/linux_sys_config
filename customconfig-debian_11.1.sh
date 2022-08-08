#!/bin/bash

USERNAME = vitor

# updating system
apt update
apt upgrade -y

# changing video server from wayland to X11
sed -i '/WaylandEnable=false/s/^#//g' /etc/gdm3/daemon.conf

# add current user to sudoers
echo "$USERNAME   ALL=(ALL:ALL) ALL" >> /etc/sudoers

#########################################################

# install media player
apt install vlc -y

# install screen recorder
apt install simplescreenrecorder -y

# install compilation toolchain
apt install build-essential -y

# install GNOME Desktop Enviroment Develoipment Tools
apt install gnome-devel -y

# install .deb package installer
apt install gdebi -y

# install git
apt install git -y

# install tree
apt install tree -y

# install micro
apt install micro -y

# install virtual Box
echo " " >> /etc/apt/sources.list
echo "# Virtualbox repo" >> /etc/apt/sources.list
echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian bullseye contrib" >> /etc/apt/sources.list
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
apt update
apt install virtualbox-6.1 -y

########################################################

# Customise bash prompt
mv /home/$USERNAME/.bashrc /home/$USERNAME/.bashrc.bak
cp ./custom_files_debian/.bashrc /home/$USERNAME/
