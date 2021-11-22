#!/bin/bash

# updating system
apt update
apt upgrade -y

# changing video server from wayland to X11
sed -i '/WaylandEnable=false/s/^#//g' /etc/gdm3/daemon.conf

# add current user to sudoers
echo "vitor   ALL=(ALL:ALL) ALL" >> /etc/sudoers

#########################################################

# install media player
apt install vlc -y

# install screen recorder
apt install simplescreenrecorder -y

# install compilation toolchain
apt install build-essential -y

# install .deb package installer
apt install gdebi -y

# install git
apt install git -y

# install virtual Box
echo " " >> /etc/apt/sources.list
echo "# Virtualbox repo" >> /etc/apt/sources.list
echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian bullseye contrib" >> /etc/apt/sources.list
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
apt update
apt install virtualbox-6.1 -y

########################################################

# reboot system to aply changes
reboot
