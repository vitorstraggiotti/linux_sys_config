#!/bin/bash

apt update

# install ssh server
apt install openssh-server -y

# https suport
apt install apt-transport-https -y

# Add tor repository
echo "# Tor repository" > /etc/apt/sources.list.d/tor.list
echo "deb     [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org bullseye main" >> /etc/apt/sources.list.d/tor.list
echo "deb-src [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org bullseye main" >> /etc/apt/sources.list.d/tor.list

# Setting up keys
wget -qO- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --dearmor | tee /usr/share/keyrings/tor-archive-keyring.gpg > /dev/null

# Install tor
apt update
apt install tor deb.torproject.org-keyring -y
apt install tor -y

## Setting up Tor and SSH server

# Setting up hidden service
echo "HiddenServiceDir /var/lib/tor/ssh_hidden_service/" >> /etc/tor/torrc
echo "HiddenServicePort 640 127.0.0.1:22" >> /etc/tor/torrc

# Restart tor service
systemctl restart tor

# Add keys to ssh server
mkdir -p ~/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDEgKjggaxd4VQA5RkvGY+1+L/PIsMHgFUayQFcKEPXjgWhCiCtTwMykfz6urNo8FxHR8CAmFuWseGRHODJ85YidZrEjzYPzukWzpm2S1eOPsDts9I/OF0L5BP55uFFA2oyQJjlOuB3Mn0tv8MljZNAwg8cI7psBTD0nitZOgZSJ1GSMASsCqEzSoDFAcFYVidy3fZ8TrnxZiSEss1+ajgsKW5vGf1t8tZXU5XjTtoFwbH5sp3pzol+yKFrNvgxcEUN9Tg2oyQyeCGiW4UM1ps/KbMpDxy2Ec8e/jhrR/WAMCAacHKRsaKCgGyuk5VL2if3ynhu0/sbKZ3mimsb1ivd4dfhruIthEnwObvACJQOKUFcd5ywb1dIWzqXGFDh50bcasd9R2DZLsTOqh0cgXDnZd1GiTSG4+Z78zzvKGPzfuveG2CMF0Ezpl/t2nICPEVNQqUiQMZiWTADV188+SMP4G3gxI8UQrqVQDqHv9wSgIGjq2sAOZTfLKs4esXbE00= vitor@debian" >> ~/.ssh/authorized_keys

# Block ssh autentication with password and login as root
echo "PermitRootLogin prohibit-password" >> /etc/ssh/sshd_config
echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

# Restart SSH server
systemctl restart ssh

## Save info for remote access
echo "Username: $USERNAME" >> ./remote_ssh_info
echo "User: $USER" >> ./remote_ssh_info
echo "Port: 640" >> ./remote_ssh_info
echo "Address: " >> ./remote_ssh_info
cat /var/lib/tor/ssh_hidden_service/hostname >> ./remote_ssh_info
