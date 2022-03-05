#!/bin/bash

apt update

apt upgrade -y

apt install apt-transport-https -y

cd /etc/apt/sources.list.d

echo "# Tor repository" > tor.list
echo "deb     [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org bullseye main" >> tor.list
echo "deb-src [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org bullseye main" >> tor.list

wget -qO- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --dearmor | tee /usr/share/keyrings/tor-archive-keyring.gpg > /dev/null

apt update

apt install tor deb.torproject.org-keyring -y

apt install tor -y

systemctl disable tor

systemctl stop tor
