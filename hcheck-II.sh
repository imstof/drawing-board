#!/bin/bash

#script to run hours file through checker.

NOW=$(date +"%Y-%m-%d")

if [[ -z $1 ]]
then
	checkedHours=$(cat ~/Documents/$NOW-cehnstrom | /projects/clients/bin/hoursvalid.pl)
else
	checkedHours=$(cat ~/Documents/$1-cehnstrom | /projects/clients/bin/hoursvalid.pl)
fi

if [$checkedHours == ""]
# && $checkedDoc== ""]
then
	printf "\n\n"
	echo "Nailed it!"
	printf "\n"
	
	read -p "Move it? " yn
	if [ $yn == "y" ]
	then
		if [ -z $1 ]
		then
			hmove
		else
			hmove $1
		fi
	fi
	exit
else
	printf "\n\n"
	echo "Fix it!"
	printf "\n"
	echo $checkedDoc
	echo "$checkedHours" | grep \# 
	printf "\n\n"
fi
