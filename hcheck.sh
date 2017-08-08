#!/bin/bash

#script to run hours file through checker.

file=~/Documents/$(date --date="$1" +"%Y-%m-%d")-cehnstrom

if [[ $(cat $file | /projects/clients/bin/hoursvalid.pl) == "" ]]
then
	printf "\n\n"
	echo "Nailed it!"
	printf "\n"
	
	read -p "Move it? " yn
	if [ $yn == "y" ]
	then
		year=$(date --date="$1" +"%Y")
		month=$(date --date="$1" +"%m")
		mkdir -p ~/Documents/Hours-$year
		mkdir -p ~/Documents/Hours-$year/$month
		cp $file ~/Documents/Hours-$year/$month
	fi
	exit
else
	printf "\n\n"
	echo "Fix it!"
	printf "\n"
	echo $file
	cat $file | /projects/clients/bin/hoursvalid.pl | grep \#
	printf "\n\n"
fi
