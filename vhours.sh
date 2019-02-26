#!/bin/bash

#Open current hours file

FILEDATE=$(date --date="$1" +"%Y-%m-%d")

vim ~/Documents/$FILEDATE-cehnstrom

echo
vcheck "$1"
echo
read -t 30 -p "Sync Documents folder? " yn

if [ -z "$yn" ]
then
	exit 0
fi

if [ $yn == "y" ]
then
	quicksync
fi
