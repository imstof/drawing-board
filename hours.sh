#!/bin/bash

# A script to automatically generate file for entering hours

# Exit if file exists already.

#If no time given, generate current 1/4 hour, else $1
if [ -z "$1" ]
then
	if [ $(date +"%M") -ge "00" ] && [ $(date +"%M") -le "14" ]
	then
		smin=00
	elif [ $(date +"%M") -ge "15" ] && [ $(date +"%M") -le "29" ]
	then
		smin=15
	elif [ $(date +"%M") -ge "30" ] && [ $(date +"%M") -le "44" ]
	then
		smin=30
	else
		smin=45
	fi
	stime="$(date +"%H"):$smin"
else
	stime=$1
fi

#If no date given, current date. else $2
if [ -z "$2" ]
then
	now=$(date +"%Y-%m-%d")
else
	now=$2
fi

if [ -e ~/Documents/$now-cehnstrom ]
then
	echo ""
	echo "File: ~/Documents/"$now"-cehnstrom already exists."
	echo ""
	exit 0
fi

file=~/Documents/$now-cehnstrom

echo "cehnstrom|$now $stime|$now ||TS|Y|N|email,misc" >> $file
echo "cehnstrom|$now $stime|$now ||HOME|Y|N|domestic duties" >> $file
echo "cehnstrom|$now |$now |0.75|HOME|Y|N|to mghpcc" >> $file
echo "cehnstrom|$now |$now |0.25|HOLYOKE|Y|N|walkthrough" >> $file
echo "cehnstrom|$now |$now ||TS|Y|N|email,issues" >> $file
echo "cehnstrom|$now |$now ||TS|Y|N|learning" >> $file
echo "cehnstrom|$now |$now ||ENGAGING|Y|N|" >> $file
echo "cehnstrom|$now |$now ||C3DDB|Y|N|" >> $file
echo "cehnstrom|$now |$now ||HOLYOKE|Y|N|" >> $file
echo "cehnstrom|$now |$now ||NEURO|Y|N|" >> $file
echo "cehnstrom|$now |$now |||Y|N|" >> $file
echo "cehnstrom|$now |$now |1|LUNCH|Y|N|lunch" >> $file
echo "cehnstrom|$now |$now ||TS|Y|N|email,issues" >> $file
echo "cehnstrom|$now |$now ||TS|Y|N|learning" >> $file
echo "cehnstrom|$now |$now ||ENGAGING|Y|N|" >> $file
echo "cehnstrom|$now |$now ||C3DDB|Y|N|" >> $file
echo "cehnstrom|$now |$now ||HOLYOKE|Y|N|" >> $file
echo "cehnstrom|$now |$now ||NEURO|Y|N|" >> $file
echo "cehnstrom|$now |$now |0.25|HOLYOKE|Y|N|walkthrough" >> $file

if [ -z "$1" ]
then
	echo "$file generated with start time of $stime."
	quicksync
	exit 0
fi
vim $file
