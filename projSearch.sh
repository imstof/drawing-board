#!/bin/bash

# search across years, months

# get dates
read -p "Start date YYYY-MM-DD (default Monday): " sdate
read -p "End date YYYY-MM-DD (default today): " edate
if [ -z $sdate ]
then
	if [[ $(date +"%a") != "Mon" ]]
	then
		sdate=$(date +"%Y-%m-%d")
	else
		sdate=$(date --date="last monday" +"%Y-%m-%d")
	fi
fi
if [ -z $edate ]
then
	edate=$(date +"%Y-%m-%d")
fi

read -p "Project code: " proj

# get months/years
syear=$(echo $sdate | cut -d'-' -f1)
eyear=$(echo $edate | cut -d'-' -f1)
smonth=$(echo $sdate | cut -d'-' -f2)
emonth=$(echo $edate | cut -d'-' -f2)
echo "smonth :"$smonth   #test
echo "emonth :"$emonth   #test
echo "syear :"$syear 	 #test
echo "eyear :"$eyear 	 #test

		ydir=~/Documents/Hours-$syear/
		echo "ydir: "$ydir			#test
		smonth=$smonth
		echo "smonth: "$smonth			#test
# search directories

echo "command run on: "$(date +"%Y-%m-%d %T") >> ~/Documents/temphfiles	#test

# if starting and ending in differnet years, check all files from start date to 12/31
	while [[ $syear -le $eyear ]]
	do
		if [[ $syear -lt $eyear ]]
		then
			ydir=~/Documents/Hours-$syear/
			echo "ydir: "$ydir			#test

			while [[ $((10#$smonth)) -lt "13" ]]
			do
				fdir=$ydir$smonth
				echo "fdir: "$fdir			#test
				for file in $fdir/*
				do
					echo "file: "$file >> ~/Documents/temphfiles			#test
					fdate=$(echo $file | cut -d'/' -f7 | cut -d'-' -f1-3)
					if [[ $fdate == $sdate || $fdate > $sdate ]]
					then
						cat $file | awk -F "|" "/$proj/ {print \$4}" >> ~/Documents/temphours
					fi
				done

				printf -v smonth '%02d' $((10#$smonth+1))
			done
			smonth=01
			((syear++))
		elif [[ $syear == $eyear ]]
		then
			ydir=~/Documents/Hours-$syear/
			echo "ydir: "$ydir			#test

			while [[ $((10#$smonth)) -le $emonth ]]
			do
				fdir=$ydir$smonth
				echo "fdir: "$fdir			#test
				for file in $fdir/*
				do
					echo "file: "$file >> ~/Documents/temphfiles			#test
					fdate=$(echo $file | cut -d'/' -f7 | cut -d'-' -f1-3)
					if [[ $fdate == $sdate || $fdate > $sdate ]]
					then
						cat $file | awk -F "|" "/$proj/ {print \$4}" >> ~/Documents/temphours
					fi
				done
				printf -v smonth '%02d' $((10#$smonth+1))
			done
			((syear++))
		fi


	done

# sum hours
sed '/^$/d' ~/Documents/temphours > ~/Documents/temphours2
echo "Total hours worked on "$proj" == "$(paste -sd+ ~/Documents/temphours2 | bc)
rm ~/Documents/temphours*
