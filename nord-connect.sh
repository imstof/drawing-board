#!/bin/bash

# edit vpn connect to best server and connect
# MUST BE SUDO'd

#check for existing config file
[[ -e /etc/openvpn/ovpn_udp/us$1.nordvpn.com.udp.ovpn ]] || wget https://downloads.nordcdn.com/configs/files/ovpn_udp/servers/us$1.nordvpn.com.udp.ovpn -O /etc/openvpn/ovpn_udp/us$1.nordvpn.com.udp.ovpn

#pull ip && port from config file
#regex to get "remote followed by space + number" for ip/port fields
NORDIP=
NORDPORT=

#sed /etc/NetworkManager/system-connections/nord-vpn to change ip/port
#that should work?
