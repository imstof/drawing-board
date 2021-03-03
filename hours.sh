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

#Fill out morning care&&feeding bits
incdate=$(date -d $stime +%s)
((incdate=incdate+900))
stime15=$(date -d @$incdate +%H:%M)
((incdate=incdate+900))
stime30=$(date -d @$incdate +%H:%M)
((incdate=incdate+900))
stime45=$(date -d @$incdate +%H:%M)
((incdate=incdate+900))
stime60=$(date -d @$incdate +%H:%M)
((incdate=incdate+900))
stime75=$(date -d @$incdate +%H:%M)
((incdate=incdate+900))
stime90=$(date -d @$incdate +%H:%M)
((incdate=incdate+900))
stime105=$(date -d @$incdate +%H:%M)


#If no date given, current date. else $2
#if [ -z "$2" ]
#then
#	now=$(date +"%Y-%m-%d")
#else
#	now=$(date --date=$2 +"%Y-%m-%d")
#fi
#
#if [ -e ~/Documents/$now-cehnstrom ]
#then
#	echo ""
#	echo "File: ~/Documents/"$now"-cehnstrom already exists."
#	echo ""
#	exit 0
#fi
#
#file=~/Documents/$now-cehnstrom
#
#echo "cehnstrom|$now $stime|$now $stime15|0.25|TS|Y|N|email,misc" >> $file
#echo "cehnstrom|$now $stime30|$now $stime45|0.25|C3DDB|Y|N|care&&feeding" >> $file
#echo "cehnstrom|$now $stime60|$now $stime75|0.25|ENGAGING|Y|N|care&&feeding" >> $file
#echo "cehnstrom|$now $stime90|$now $stime105|0.25|SATORI|Y|N|care&&feeding" >> $file
#echo "cehnstrom|$now |$now ||HOME|Y|N|domestic_duties" >> $file
##echo "cehnstrom|$now |$now |0.25|HOLYOKE|Y|N|walkthrough" >> $file
##echo "cehnstrom|$now |$now |0.25|CDS|Y|N|logs" >> $file
#echo "cehnstrom|$now |$now ||TS|Y|N|email,misc" >> $file
#echo "cehnstrom|$now |$now ||ENGAGING|Y|N|" >> $file
#echo "cehnstrom|$now |$now ||C3DDB|Y|N|" >> $file
#echo "cehnstrom|$now |$now ||HPC/HELP|Y|N|c3ddb_user_help" >> $file
#echo "cehnstrom|$now |$now ||HOLYOKE|Y|N|" >> $file
#echo "cehnstrom|$now |$now ||MIT/EAPS/JP|Y|N|" >> $file
##echo "cehnstrom|$now |$now ||NEURO|Y|N|" >> $file
##echo "cehnstrom|$now |$now ||SPHHS|Y|N|" >> $file
#echo "cehnstrom|$now |$now ||SATORI|Y|N|" >> $file
#echo "cehnstrom|$now |$now ||PTO|Y|N|no_notes_req" >> $file
#echo "cehnstrom|$now |$now ||PTO/SICK|Y|N|no_notes_req" >> $file
#echo "cehnstrom|$now |$now ||PTO/DEPENDENT|Y|N|no_notes_req" >> $file
#echo "cehnstrom|$now |$now ||LUNCH|Y|N|lunch" >> $file
#echo "cehnstrom|$now |$now |||Y|N|" >> $file
#
#if [ -z "$1" ]
#then
#	echo "$file generated with start time of $stime."
#	quicksync
#	exit 0
#fi
#vim $file
#quicksync
#
