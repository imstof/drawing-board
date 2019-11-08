#!/bin/bash

#quick check of contract hours

if [[ -z $1 ]]
then
	NOW=$(date +"%Y-%m-%d")
else
	NOW=$1
fi

echo
echo "Hours|Project|Notes"
cat ~/Documents/$NOW-cehnstrom | sed '/HOME/d' | sed '/LUNCH/d' | cut -d'|' -f4,5,8 | awk -F'|' '$1!=""'

echo
echo "Total: "$(cat ~/Documents/$NOW-cehnstrom | sed '/HOME/d' | sed '/LUNCH/d' | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc)
