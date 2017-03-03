#!/bin/bash

#Open current hours file

NOW=$(date +"%Y-%m-%d")

vim ~/Documents/$NOW-cehnstrom

echo ""
read -p "Sync Documents folder? " yn

if [ $yn == "y" ]
then
	quicksync
fi
