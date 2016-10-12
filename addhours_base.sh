#!/bin/bash
#Find sum of hours worked on given client for given timeframe

#thisyear=$(date +"%Y")

#prompt for input
echo ""
echo "Find sum of hours worked on given client"
echo "========================================"
echo ""
#check host. If aquinas use project/hours/ directory M-today, else prompt
if [ $HOSTNAME = "planetaquinas" ]
then
	echo "You are on" $HOSTNAME
	echo "You will search /projects/hours/$(date +"%Y")"
	echo "Default start/end dates are:"
	echo "Start: " $(date --date="last monday" +"%Y-%m-%d")
	echo "End: " $(date +"%Y-%m-%d")
	dir=/projects/hours/$(date +"%Y")/
	sdate=$(date --date="last monday" +"%Y-%m-%d")
	edate=$(date +"%Y-%m-%d")

else  #Get dir, start, and end dates. If ~/Documents use today
	echo "Enter directory to search"
	echo "Default is ~/Documents/ searching $(date +"%Y-%m-%d")"
	read -e -p "Directory: " dir
	if [ -z "$dir" ]
	then
		dir=~/Documents
		sdate=$(date +"%Y-%m-%d")
		edate=$(date +"%Y-%m-%d")
	else
		echo -n "Enter start date (YYYY-MM-DD)(default is Monday): "
		read sdate
		if [ -z "$sdate" ]
		then
			sdate=$(date --date="last monday" +"%Y-%m-%d")
		fi
		echo -n "Enter end date (YYYY-MM-DD)(default is today): "
		read edate
		if [ -z "$edate" ]
		then
			edate=$(date +"%Y-%m-%d")
		fi
	fi
fi

# Get files, cut and sum cluster hours

