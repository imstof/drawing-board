#!/bin/bash

# edit vpn connect to best server
# MUST BE SUDO'd

#check for existing config file
[[ -e /etc/openvpn/ovpn_udp/us$1.nordvpn.com.udp.ovpn ]] || wget https://downloads.nordcdn.com/configs/files/ovpn_udp/servers/us$1.nordvpn.com.udp.ovpn -O /etc/openvpn/ovpn_udp/us$1.nordvpn.com.udp.ovpn

#pull ip && port from config file
NORDIP=$(cat /etc/openvpn/ovpn_udp/us$1.nordvpn.com.udp.ovpn | awk '/^remote\s/ {print $2}')
NORDPORT=$(cat /etc/openvpn/ovpn_udp/us$1.nordvpn.com.udp.ovpn | awk '/^remote\s/ {print $3}')

echo $NORDIP
echo $NORDPORT

#sed /etc/NetworkManager/system-connections/foo to change ip/port
#regex to replace line after match
sed -i 'foo' /etc/NetworkManager/system-connections/nord-vpn

#that should work?
