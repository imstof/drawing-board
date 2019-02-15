#!/bin/bash

vim ~/notes

read -p "Sync Documents folder? " yn

if [ $yn == "y" ]
then
	quicksync
fi
