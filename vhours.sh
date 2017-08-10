#!/bin/bash

#Open current hours file

FILEDATE=$(date --date="$1" +"%Y-%m-%d")

vim ~/Documents/$FILEDATE-cehnstrom

echo ""
read -p "Sync Documents folder? " yn

if [ $yn == "y" ]
then
	quicksync
fi
