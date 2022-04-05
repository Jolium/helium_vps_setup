#!/bin/sh

echo update system
apt update
apt upgrade -y

echo install wireguard
sudo apt install wireguard -y

echo = generating private/public keys =
wg genkey | sudo tee /etc/wireguard/privatekey | wg pubkey | sudo tee /etc/wireguard/publickey
wg genkey | sudo tee /etc/wireguard/hotspot-privatekey | wg pubkey | sudo tee /etc/wireguard/hotspot-publickey

echo = saving keys to ws_keys =
cd
touch ws_keys.txt
truncate -s 0 ws_keys.txt

VALUE_1=$(cat /etc/wireguard/privatekey)
echo "value #1 (privatekey):" >> ws_keys.txt
echo "$VALUE_1" >> ws_keys.txt
echo "" >> ws_keys.txt

echo "value #2 (publickey):" >> ws_keys.txt
cat /etc/wireguard/publickey >> ws_keys.txt
echo "" >> ws_keys.txt

echo "value #3 (hotspot-privatekey):" >> ws_keys.txt
cat /etc/wireguard/hotspot-privatekey >> ws_keys.txt
echo "" >> ws_keys.txt

VALUE_4=$(cat /etc/wireguard/hotspot-publickey)
echo "value #4 (hotspot-publickey):" >> ws_keys.txt
echo "$VALUE_4" >> ws_keys.txt
echo "" >> ws_keys.txt

echo = downloading conf file =
cd /etc/wireguard/
wget https://raw.githubusercontent.com/Jolium/helium_vps_setup/main/wg0.conf

echo = substituting values on wg0.conf file =
sed -i "s/VALUE_#1_GOES_HERE/$VALUE_1/g" wg0.conf
sed -i "s/VALUE_#4_GOES_HERE/$VALUE_4/g" wg0.conf

echo = uncomment ipv4 forwarding =
sed -i "s/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g"  /etc/sysctl.conf

echo = enabling wg0.service =
systemctl enable wg-quick@wg0.service

echo = finished =
