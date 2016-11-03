#!/bin/bash

# search across months

# get dates
read -p "Start date: " sdate
read -p "End date (default today): " edate
if [ -z $sdate ]
then
	sdate="2014-06-22"
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
proj="TS"		 #test
echo "smonth :"$smonth   #test
echo "emonth :"$emonth   #test
echo "syear :"$syear 	 #test
echo "eyear :"$eyear 	 #test

		ydir=~/Documents/Hours-$syear/
		echo "ydir: "$ydir			#test
		smonth=$smonth
		echo "smonth: "$smonth			#test
# search directories

# if current year, check files from start date to end date
#if [[ $syear = $eyear ]]
#then
	
echo "command run on: "$(date +"%Y-%m-%d %T") > ~/Documents/temphoursfiles	#test

# if starting and ending in differnet years, check all files from start date to 12/31
if [[ $syear < $eyear ]]
then
	while [[ $syear -le $eyear ]]
	do
		ydir=~/Documents/Hours-$syear/
		echo "ydir: "$ydir			#test

		if [[ ${smonth:0:1} == 0 ]]
		then
			smonth=${smonth:1:1}
		fi
		while [[ $smonth -lt "13" ]]
		do
			if [[ -z ${smonth:1:1} ]]
			then
				smonth=0$smonth
			fi
			fdir=$ydir$smonth
			echo "fdir: "$fdir			#test
			for file in $fdir/*
			do
				echo "file: "$file > ~/Documents/temphoursfiles			#test
				fdate=$(echo $file | cut -d'/' -f7 | cut -d'-' -f1-3)
				if [[ $fdate == $sdate || $fdate > $sdate ]]
				then
					cat $file | awk -F "|" "/$proj/ {print \$4}" >> ~/Documents/temphours
				fi
			done
			if [[ ${smonth:0:1} == 0 ]]
			then
				smonth=${smonth:1:1}
			fi
			((smonth++))
#			echo "after increment, the value of smonth is: "$smonth
		done
		smonth=1
		((syear++))
	done
fi

# sum hours
sed '/^$/d' ~/Documents/temphours > ~/Documents/temphours2
echo "Total hours worked on "$proj" == "$(paste -sd+ ~/Documents/temphours2 | bc)
rm ~/Documents/temphours*
