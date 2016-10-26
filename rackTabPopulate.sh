#!/bin/bash

#quick script to feed properly formatted data to racktables file

#prompt for input
#assume all items are for same pool to save typing input
read -p "What cluster are you adding devices to? " dPp

yn="y"
while [[ $yn == "y" || $yn == "Y" ]]
do

	read -p "Row? " row
	read -p "Pod? " pod
	read -p "Cabinet? " cab
#ADD BITS TO VALIDATE INPUT?

#stay in same rpc if desired
	yn2="y"
	while [[ $yn2 == "y" || $yn2 == "Y" ]]
	do
		read -p "Device Name? " dId
		read -p "Lower U? " lo
		read -p "Upper U? " hi
		read -p "Device Type? " dT
		read -p "Group? " dPg
#ADD BITS TO VALIDATE INPUT?

#append line to file
		echo "{'dId':'$dId',   'r':$row,'p':'$pod','c':$cab,'lo':$lo,'hi':$hi,'dT':'$dT',    'dPp':'$dPp','dPg':'$dPg' }," >> ~/Documents/temprackfile.txt
		read -p "Add another device in this cabinet? " yn2
		yn2=${yn2:0:1}
	done

	read -p "Add another device to this cluster? " yn
	yn=${yn:0:1}
done
