#!/bin/bash

# search across months

# get dates
read -p "Start date: " sdate
read -p "End date (default today): " edate
if [ -z $sdate ]
then
	sdate="2015-09-01"
fi
if [ -z $edate ]
then
	edate=$(date +"%Y-%m-%d")
fi

# get months/years
syear=$(echo $sdate | cut -d'-' -f1)
eyear=$(echo $edate | cut -d'-' -f1)
smonth=$(echo $sdate | cut -d'-' -f2)
emonth=$(echo $edate | cut -d'-' -f2)
proj="TS"
echo "smonth :"$smonth    #test
echo "emonth :"$emonth    #test
echo "syear :"$syear  #test
echo "eyear :"$eyear    #test

# search directories
if [[ $syear < $eyear ]]
then
	while [[ $syear -lt $eyear ]]
	do
			dir=~/Documents/Hours-$syear/
			for file in $dir*
			do
				cat $file | awk -F "|" "/$proj/ {print \$4}" >> ~/Documents/temphours
			done
		((syear++))
	done
fi
