#!/bin/bash

# search across months

# get dates
read -p "Start date: " sdate
read -p "End date (default today): " edate
if [ -z $sdate ]
then
	sdate="2015-11-22"
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
		mdir=$smonth
		echo "mdir: "$mdir			#test
		wtf=$ydir$mdir
		echo "wtf: "$wtf			#test
# search directories

# if current year, check files from start date to end date
#if [[ $syear = $eyear ]]
#then
	

# if starting and ending in differnet years, check all files from start date to 12/31
if [[ $syear < $eyear ]]
then
	while [[ $syear -lt $eyear ]]
	do
		ydir=~/Documents/Hours-$syear/
		echo "ydir: "$ydir			#test
		mdir=$smonth
		echo "mdir: "$mdir			#test
		while [[ $mdir -lt "13" ]]
		do
			if [[ -z ${mdir:1:1} ]]
			then
				mdir=0$mdir
			fi
			fdir=$ydir$mdir
			echo "fdir: "$fdir			#test
			for file in $fdir/*
			do
				echo "file: "$file			#test
				fdate=$(echo $file | cut -d'/' -f7 | cut -d'-' -f1-3)
				if [[ $fdate == $sdate || $fdate > $sdate ]]
				then
					cat $file | awk -F "|" "/$proj/ {print \$2}" >> ~/Documents/temphours
				fi
			done
			if [[ ${mdir:0:1} == 0 ]]
			then
				mdir=${mdir:1:1}
			fi
			((mdir++))
			echo "after increment, the value of mdir is: "$mdir
		done
		smonth=
		((syear++))
	done
fi


