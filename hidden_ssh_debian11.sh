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
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDJa7R/RaD9v4c6td5Vk3aVTDVRiP71zrJMUX4w8ibNPMZYA8vSrGQgJyGzRH8G1NhV3ZTLWwLIR+37MwA2TR3PF40yTEuBsPltJnReri+0Dc/JPbTQK6HyJtsdl1tIk9UCUk8zbUGx1oYd9n43BNOpG/96+UxeneqOfGXT6iZuFzZRW9CRGHH8jjQ8qo7wi9MmrSa4GS0dEo/eIsN8mnnYWY9q7mfR+6sXS10zjl+qgbUazcYxJhT5f+1Y/dQwBh3QZXyYdQklAeOCnJUa8bu/G3G6iwMfysjVX21+bvif9qw7Qy40jeA6pC9zelXvKGG6xhKZ8J9E1xozsL4Z5vDGiq8veqd0qf8iNfFgRBLT9wgEZFx/1N9QmB+dLhFvCAhvxDn8VsWR2CwJBmpf6yCp5Kx7OWxZA/jBhgzjouDEz41jUQMUT6OjP3402pFAJW8oFdjTQsrC+7eDya4jXvrPsR59TMNDgTqtvPc6AQUYB2L/NAUeILqUewn0AjA71KUeFUTVpOaIs6rmIUm9jyWjSd2WW8MaydLdaGuE3ra5xjYCmeoeJQpgn0LS52QefMxdmn2sdUNkarT9nSCW+0OD8awfmn5pXF6z/j3vqtdK+MIGk0/7Rr3hXrq5Kw3WvQ5M3fahAG5sZTtp202m4G9ZTy0Sq2Z0pN6Vfdu2kfKMEw== vitor@mainAcer" >> ~/.ssh/authorized_keys

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
