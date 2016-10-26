#!/bin/bash

#quick script to feed properly formatted data to racktables file

#prompt for input
read -p "Device Name? " dId
read -p "Row? " row
read -p "Pod? " pod
read -p "Cabinet? " cab
read -p "Lower U? " lo
read -p "Upper U? " hi
read -p "Device Type? " dT
read -p "Pool? " dPp
read -p "Group? " dPg


#append line to file, stay in same rpc if desired
yn="y"
while [[ $yn == "y" || $yn == "Y" ]]
do
	echo "{'dId':'$dId',   'r':$row,'p':'$pod','c':$cab,'lo':$lo,'hi':$hi,'dT':'$dT',    'dPp':'$dPp','dPg':'$dPg' }, >> ~/Documents/temprackfile.txt




{'dId':'node444',   'r':5,'p':'c','c':15,'lo':18,'hi':18,'dT':'Dell R430',    'dPp':'engaging','dPg':'' },
