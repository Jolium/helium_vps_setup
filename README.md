# How to install WireGuard and enable port forwarding

### 1. Log in to your VPS (with PuTTY or ssh)

### 2. Download install_wireguard.sh
wget https://raw.githubusercontent.com/Jolium/helium_vps_setup/main/install_wireguard.sh

### 3. Make file executable
chmod +x install_wireguard.sh

### 4. Run file
./install_wireguard.sh

### 5. When it finishes to run, reboot your vps
reboot

### 6. After 30s log in to your VPS and check if everything is running correctly
wg

### 7. You should get something like the following:
interface: wg0
<br />&nbsp;&nbsp;&nbsp;&nbsp;public key: sRbfPRWU+4t7gr1kxO9nMIawIt2weRkz61MjGg4Mh7S=
<br />&nbsp;&nbsp;&nbsp;&nbsp;private key: (hidden)
<br />&nbsp;&nbsp;&nbsp;&nbsp;listening port: 51820
  
peer: 4j/dju7lk8nL/Kj6Tlsj73lcJl+/mjkHOl688f5/H5N=
<br />&nbsp;&nbsp;&nbsp;&nbsp;endpoint: 0.0.0.0:51820
<br />&nbsp;&nbsp;&nbsp;&nbsp;allowed ips: 10.0.1.2/32
