#!/bin/bash

vim ~/todo

read -p "Sync Documents folder? " yn

if [ -z "$yn" ]
then
	exit 0
fi

if [ $yn == "y" ]
then
	quicksync
fi
