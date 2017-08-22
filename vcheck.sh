#!/bin/bash

#quick check of contract hours

FILEDATE=$(date --date="$1" +"%Y-%m-%d")
ONCLOCK=$(cat ~/Documents/$FILEDATE-cehnstrom | sed '/HOME/d' | sed '/LUNCH/d' | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc)
OFFCLOCK=$(cat ~/Documents/$FILEDATE-cehnstrom | grep -e HOME -e LUNCH | cut -d'|' -f4     | sed '/^$/d' | paste -sd+ | bc)

START=$(echo $(
	z=23.75
	for x in $(cat ~/Documents/$FILEDATE-cehnstrom | cut -d'|' -f2 | cut -d' ' -f2 | sed s/:15/.25/g| sed s/:30/.50/g | sed s/:45/.75/g | sed s/:00/.00/g)
	do
		for y in $(cat ~/Documents/$FILEDATE-cehnstrom | cut -d'|' -f2 | cut -d' ' -f2 | sed s/:15/.25/g| sed s/:30/.50/g | sed s/:45/.75/g | sed s/:00/.00/g)
		do
			if [[ $(echo $x"<"$y | bc) == 1 && $(echo $x"<"$z | bc) == 1 ]]
			then
				z=$x
			fi
		done
	done
	echo $z
))
echo "START="$START		#TEST

END=$(echo $(
	z=00.00
	for x in $(cat ~/Documents/$FILEDATE-cehnstrom | cut -d'|' -f3 | cut -d' ' -f2 | sed s/:15/.25/g| sed s/:30/.50/g | sed s/:45/.75/g | sed s/:00/.00/g)
	do
		for y in $(cat ~/Documents/$FILEDATE-cehnstrom | cut -d'|' -f3 | cut -d' ' -f2 | sed s/:15/.25/g| sed s/:30/.50/g | sed s/:45/.75/g | sed s/:00/.00/g)
		do
			if [[ $(echo $x">"$y | bc) == 1 && $(echo $x">"$z | bc) == 1 ]]
			then
				z=$x
			fi
		done
	done
	echo $z
))
echo "END="$END			#TEST

HOURS=$(echo $END"-"$START | bc)

echo "HOURS="$HOURS			#TEST

echo
echo "On-The-Clock"
echo "Hours|Project|Notes"
cat ~/Documents/$FILEDATE-cehnstrom | sed '/HOME/d' | sed '/LUNCH/d' | cut -d'|' -f4,5,8 | awk -F'|' '$1!=""'

echo

echo "Total On-The-Clock: "$ONCLOCK

echo
echo "Off-The-Clock"
echo "Hours|Project|Notes"
cat ~/Documents/$FILEDATE-cehnstrom | grep -e HOME -e LUNCH | cut -d'|' -f4,5,8 | awk     -F'|' '$1!=""'
echo
echo "Total Off-The-Clock: "$OFFCLOCK
echo
echo "Total Hours: "$(echo $ONCLOCK"+"$OFFCLOCK | bc)
echo "Hours Unaccounted For: "$(echo $HOURS"-"$(echo $ONCLOCK"+"$OFFCLOCK | bc) | bc)
