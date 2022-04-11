#!/bin/sh

echo update system
apt update
apt upgrade -y

echo install wireguard
sudo apt install wireguard -y

echo = generating private/public keys =
wg genkey | sudo tee /etc/wireguard/privatekey | wg pubkey | sudo tee /etc/wireguard/publickey
wg genkey | sudo tee /etc/wireguard/hotspot-privatekey | wg pubkey | sudo tee /etc/wireguard/hotspot-publickey

echo = saving keys to wg_keys.txt =
cd
touch wg_keys.txt
truncate -s 0 wg_keys.txt

VALUE_1=$(cat /etc/wireguard/privatekey)
echo "value #1 (privatekey):" >> wg_keys.txt
echo "$VALUE_1" >> wg_keys.txt
echo "" >> wg_keys.txt

echo "value #2 (publickey):" >> wg_keys.txt
cat /etc/wireguard/publickey >> wg_keys.txt
echo "" >> wg_keys.txt

echo "value #3 (hotspot-privatekey):" >> wg_keys.txt
cat /etc/wireguard/hotspot-privatekey >> wg_keys.txt
echo "" >> wg_keys.txt

VALUE_4=$(cat /etc/wireguard/hotspot-publickey)
echo "value #4 (hotspot-publickey):" >> wg_keys.txt
echo "$VALUE_4" >> wg_keys.txt
echo "" >> wg_keys.txt

echo = downloading wg0.conf file =
cd /etc/wireguard/
[ -e wg0.conf ] && rm -- wg0.conf
wget https://raw.githubusercontent.com/Jolium/helium_vps_setup/main/wg0.conf

echo = substituting values on wg0.conf file =
sed -i "s/VALUE_#1_GOES_HERE/$VALUE_1/" wg0.conf
sed -i "s/VALUE_#4_GOES_HERE/$VALUE_4/" wg0.conf

echo = uncomment ipv4 forwarding =
sed -i "s/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g"  /etc/sysctl.conf

echo = enabling wg0.service =
systemctl enable wg-quick@wg0.service

echo = finished =
