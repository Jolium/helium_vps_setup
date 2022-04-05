# How to install WireGuard and enable port forwarding

### Watch Justin Kace's video until 4:20: https://www.youtube.com/watch?v=GYf7xjxgyRo&t=1s&ab_channel=JustinKace
### Now you can skip all step 8 on Justin Kace's video (8.a to 8.i) with this script
<br />

### 1. Log in to your VPS (with PuTTY or ssh) if you are not already logged in

### 2. Download install_wireguard.sh
wget https://raw.githubusercontent.com/Jolium/helium_vps_setup/main/install_wireguard.sh

### 3. Make file executable
chmod +x install_wireguard.sh

### 4. Run file
./install_wireguard.sh

### 5. When it finishes to run, check new created file on your home directory with all keys values (you may copy it to your pc)
cat ws_keys.txt

### >> You should get something like the following:
value #1 (privatekey):
<br />GBTChvJb+RijdtAvLQCRUEWUGA50we4MhE2Vg5AJ3F0=

value #2 (publickey):
<br />PNG67Sj2gCDgA50H6Qj2gCaHMkSwSOeBaH9ma7pFxy9=

value #3 (hotspot-privatekey):
<br />YgA50ONssK+/SahlB1Jfqi2weRkz61MjGDwSOeBaH9m=

value #4 (hotspot-publickey):
<br />t2gA50gA50we4Mh7Sj2gCaHMkSQiZfhTaYl6GVsRbfP=


### 6. Reboot your vps
reboot

### 7. After 30s log in to your VPS and check if everything is running correctly
wg

### >> You should get something like the following:
interface: wg0
<br />&nbsp;&nbsp;&nbsp;&nbsp;public key: PNG67Sj2gCDgA50H6Qj2gCaHMkSwSOeBaH9ma7pFxy9=
<br />&nbsp;&nbsp;&nbsp;&nbsp;private key: (hidden)
<br />&nbsp;&nbsp;&nbsp;&nbsp;listening port: 51820
  
peer: 4j/dju7lk8nL/Kj6Tlsj73lcJl+/mjkHOl688f5/H5N=
<br />&nbsp;&nbsp;&nbsp;&nbsp;endpoint: 0.0.0.0:51820
<br />&nbsp;&nbsp;&nbsp;&nbsp;allowed ips: 10.0.1.2/32
