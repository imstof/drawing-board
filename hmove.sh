#!/bin/bash

# Script to move hours to proper folder

NOW=$(date +'%Y-%m-%d')
YEAR=$(date +'%Y')
MONTH=$(date +'%m')

if [[ -z $1 ]]
then
	cp ~/Documents/$NOW-cehnstrom /projects/hours/$YEAR/
else
	cp ~/Documents/$1-cehnstrom /projects/hours/$(echo $1 | cut -d'-' -f1)/
fi

# Move file to personal archive

if [[ -z $1 ]]
then
	mkdir -p ~/Documents/Hours-$YEAR
	mkdir -p ~/Documents/Hours-$YEAR/$MONTH
	mv ~/Documents/$NOW-cehnstrom ~/Documents/Hours-$YEAR/$MONTH/
else
	mkdir -p ~/Documents/Hours-$(echo $1 | cut -d'-' -f1)/
	mkdir -p ~/Documents/Hours-$(echo $1 | cut -d'-' -f1)/$(echo $1 | cut -d'-' -f2)
	mv ~/Documents/$1-cehnstrom ~/Documents/Hours-$(echo $1 | cut -d'-' -f1)/$(echo $1 | cut -d'-' -f2)
fi 
