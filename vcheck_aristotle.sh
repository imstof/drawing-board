#!/bin/bash

#quick check of contract hours

FILEDATE=$(date --date="$1" +"%Y-%m-%d")
	if [[ -e ~/Documents/$FILEDATE-cehnstrom ]]
	then
		FILE=~/Documents/$FILEDATE-cehnstrom
	elif [[ -e ~/Documents/Hours-$(date --date=$FILEDATE +"%Y")/$(date --date=$FILEDATE +"%m")/$FILEDATE-cehnstrom ]]
	then
		FILE=~/Documents/Hours-$(date --date=$FILEDATE +"%Y")/$(date --date=$FILEDATE +"%m")/$FILEDATE-cehnstrom
	else
		echo "cannot find file: $FILEDATE-cehnstrom"
		exit 1
	fi

#echo "file: "$FILE		#TEST

ONCLOCK=$(cat $FILE | sed '/SICK/d' | sed '/HOME/d' | sed '/LUNCH/d' | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc)
OFFCLOCK=$(cat $FILE | grep -e HOME -e SICK -e LUNCH | cut -d'|' -f4     | sed '/^$/d' | paste -sd+ | bc)

if [[ -z $OFFCLOCK ]]
then
	OFFCLOCK=0
fi
if [[ -z $ONCLOCK ]]
then
	ONCLOCK=0
fi

echo
echo $(date -d $FILEDATE +"%A %Y-%m-%d")

START=$(echo $(
	z=23.75
	for x in $(cat $FILE | cut -d'|' -f2 | cut -d' ' -f2 | sed s/:15/.25/g| sed s/:30/.50/g | sed s/:45/.75/g | sed s/:00/.00/g)
	do
		for y in $(cat $FILE | cut -d'|' -f2 | cut -d' ' -f2 | sed s/:15/.25/g| sed s/:30/.50/g | sed s/:45/.75/g | sed s/:00/.00/g)
		do
			if [[ $(echo $x"<"$y | bc) == 1 && $(echo $x"<"$z | bc) == 1 ]]
			then
				z=$x
			fi
		done
	done
	echo $z
))
#echo "START="$START		#TEST

END=$(echo $(
	z=00.00
	for x in $(cat $FILE | cut -d'|' -f3 | cut -d' ' -f2 | sed s/:15/.25/g| sed s/:30/.50/g | sed s/:45/.75/g | sed s/:00/.00/g)
	do
		for y in $(cat $FILE | cut -d'|' -f3 | cut -d' ' -f2 | sed s/:15/.25/g| sed s/:30/.50/g | sed s/:45/.75/g | sed s/:00/.00/g)
		do
			if [[ $(echo $x">"$y | bc) == 1 && $(echo $x">"$z | bc) == 1 ]]
			then
				z=$x
			fi
		done
	done
	echo $z
))
#echo "END="$END			#TEST

HOURS=$(echo $END"-"$START | bc)

#echo "HOURS="$HOURS			#TEST

echo
echo "On-The-Clock"
echo "Hours|Project|Notes"
cat $FILE | sed '/SICK/d' | sed '/HOME/d' | sed '/LUNCH/d' | cut -d'|' -f4,5,8 | awk -F'|' '$1!=""'

echo

echo "Total On-The-Clock: "$ONCLOCK

echo
echo "Off-The-Clock"
echo "Hours|Project|Notes"
cat $FILE | grep -e HOME -e SICK -e LUNCH | cut -d'|' -f4,5,8 | awk     -F'|' '$1!=""'
echo
echo "Total Off-The-Clock: "$OFFCLOCK
echo
echo "Total Hours: "$(echo $ONCLOCK"+"$OFFCLOCK | bc)
echo "Hours Unaccounted For: "$(echo $HOURS"-"$(echo $ONCLOCK"+"$OFFCLOCK | bc) | bc)
echo
projcheck -d $1
read -t 10 -p "run vhours? " yn
if [[ -z $yn ]]
then
	exit 0
fi
if [ $yn == "y" ]
then
	vhours $1
fi
