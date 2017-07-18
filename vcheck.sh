#!/bin/bash

#quick check of contract hours

if [[ -z $1 ]]
then
	NOW=$(date +"%Y-%m-%d")
else
	NOW=$1
fi

cat ~/Documents/$NOW-cehnstrom | sed '/HOME/d' | sed '/LUNCH/d' | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc
