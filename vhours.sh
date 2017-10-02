#!/bin/bash

#Open current hours file

FILEDATE=$(date --date="$1" +"%Y-%m-%d")

vim ~/Documents/$FILEDATE-cehnstrom

echo
vcheck "$1"
echo
read -p "Sync Documents folder? " yn

if [ $yn == "y" ]
then
	quicksync
fi
