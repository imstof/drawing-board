#!/bin/bash
#Find sum of hours worked on given client for given timeframe

edate=$(date +"%Y-%m-%d")
if [ $(date +"%A") == "Monday" ]
then
	sdate=$(date +"%Y-%m-%d")
else
	sdate=$(date --date="last monday" +"%Y-%m-%d")
fi

#check host. If aquinas use project/hours/ directory M-today, else prompt
if [ $HOSTNAME = "planetaquinas" ]
then
	dir=/projects/hours/$(date +"%Y")/

	for file in $dir$(date +"%Y")*; do
#		echo $file  #test
		if [ $(echo $file | cut -d'/' -f5 | cut -d'-' -f4) == "cehnstrom" ]
		then
		
			fdate=$(echo $file | cut -d'/' -f5 | cut -d'-' -f1-3)
#			echo "I cut: "$fdate " from "$file   #test
			if [[ $fdate == $sdate || $fdate > $sdate ]]
			then
#				echo "Pulling hours from: "$file  #test
				cat $file | awk -F "|" '/ENGAGING/ {print $4;}' >> ~/Documents/temphours
				cat $file | awk -F "|" '/C3DDB/ {print $4;}' >> ~/Documents/temphours
			fi
		fi
	done
	echo ""
	echo "Total hours submitted for ENGAGING/C3DDB"
	echo "   for the week beginning "$sdate
	echo "========================================"
	echo ""

else  #If other host, use personal records
	dir=~/Documents/Hours-$(date +"%Y")/$(date +"%m")/
	if [ -e ~/Documents/$edate-cehnstrom ]
	then
		cat ~/Documents/$edate-cehnstrom | awk -F "|" '/ENGAGING/ {print $4;}' >> ~/Documents/temphours
		cat ~/Documents/$edate-cehnstrom | awk -F "|" '/C3DDB/ {print $4;}' >> ~/Documents/temphours
		for file in $dir*; do
			fdate=$(echo $file | cut -d'/' -f7 | cut -d'-' -f1-3)
			if [[ $fdate == $sdate  ||  $fdate > $sdate  &&  $fdate < $edate ]]
			then
#				echo $file  #test
				cat $file | awk -F "|" '/ENGAGING/ {print $4;}' >> ~/Documents/temphours
				cat $file | awk -F "|" '/C3DDB/ {print $4;}' >> ~/Documents/temphours
			fi
		done
	else
		for file in $dir*; do
			fdate=$(echo $file | cut -d'/' -f7 | cut -d'-' -f1-3)
			if [[ $fdate == $sdate || $fdate > $sdate ]]
			then
				cat $file | awk -F "|" '/ENGAGING/ {print $4;}' >> ~/Documents/temphours
				cat $file | awk -F "|" '/C3DDB/ {print $4;}' >> ~/Documents/temphours
			fi
		done
	fi
	echo ""
	echo "  Total hours worked on ENGAGING/C3DDB"
	echo "   for the week beginning "$sdate
	echo "========================================"
	echo ""
fi

#cat ~/Documents/temphours  #test
sed '/^$/d' ~/Documents/temphours > ~/Documents/temphours2
#echo ""   #test
#cat ~/Documents/temphours2  #test
echo "               "$(paste -sd+ ~/Documents/temphours2 | bc)
echo ""
rm ~/Documents/temphours*

# Check a different timeframe or client

read -p "Would you like to check other hours? " yn
if [[ ${yn:0:1} == "y" || ${yn:0:1} == "Y" ]]
then
	while true
	do
		read -p "Enter start date as YYYY-MM-DD (default is 1st of month): " sdate
		if [ -z "$sdate" ]
		then
			sdate=$(date +"%Y-%m-01")
		fi
	echo $sdate  #test
		if [[ ${sdate:4:1} == "-" && ${sdate:7:1} == "-" && "$sdate" -eq "$sdate" ]] 2>/dev/null
		then
			break
		fi
	echo "Please enter a valid date."
	done

	while true
	do
		read -p "Enter end date as YYYY-MM-DD (default is today): " edate
		if [ -z "$edate" ]
		then
			edate=$(date +"%Y-%m-%d")
		fi
	echo $edate  #test
		if [[ ${edate:4:1} == "-" && ${edate:7:1} == "-" && "$edate" -eq "$edate" ]] 2>/dev/null
		then
			break
		fi
	echo "Please enter a valid date."
	done

	while true
	do
		read -p "Enter project code: " proj
		if [ -n "$proj" ]
		then
			break
		fi
	echo "Please enter a valid project code"
	done

	if [ $HOSTNAME = "planetaquinas" ]
	then
		dir=/projects/hours/$(date +"%Y")/

		for file in $dir$(date +"%Y")*; do
#			echo $file  #test
			if [ $(echo $file | cut -d'/' -f5 | cut -d'-' -f4) == "cehnstrom" ]
			then
			
				fdate=$(echo $file | cut -d'/' -f5 | cut -d'-' -f1-3)
#				echo "I cut: "$fdate " from "$file   #test
				if [[ $fdate == $sdate || $fdate > $sdate ]]
				then
#					echo "Pulling hours from: "$file  #test
					cat $file | awk -F "|" '/$proj/ {print $4;}' >> ~/Documents/temphours
				fi
			fi
		done
		echo ""
		echo "Total hours submitted for "$proj
		echo "from "$sdate" to "$edate
		echo "========================================"
		echo ""

	else  #If other host, use personal records
		dir=~/Documents/Hours-$(date +"%Y")/$(date +"%m")/
		if [ -e ~/Documents/$edate-cehnstrom ]
		then
			cat ~/Documents/$edate-cehnstrom | awk -F "|" '/$proj/ {print $4;}' >> ~/Documents/temphours
			for file in $dir*; do
				fdate=$(echo $file | cut -d'/' -f7 | cut -d'-' -f1-3)
				if [[ $fdate == $sdate  ||  $fdate > $sdate  &&  $fdate < $edate ]]
				then
#					echo $file  #test

				#######  PROBLEM w AWK variable

					cat $file | awk -F "|" '/$proj/ {print $4;}' >> ~/Documents/temphours
				fi
			done
		fi
		echo ""
		echo "  Total hours worked on "$proj
		echo "from "$sdate" to "$edate
		echo "========================================"
		echo ""
	fi
	
#cat ~/Documents/temphours  #test
sed '/^$/d' ~/Documents/temphours > ~/Documents/temphours2
#echo ""   #test
#cat ~/Documents/temphours2  #test
echo "               "$(paste -sd+ ~/Documents/temphours2 | bc)
echo ""
rm ~/Documents/temphours*

else
	exit 0

fi
