#!/bin/bash

# check hours worked on project codes

# help func
show_help(){
	echo
	echo "Usage: `basename $0` [option] ..."
	echo "Report of hours worked on projects"
	echo
	echo "	-s START DATE"
	echo "		start date (default Monday)"
	echo "		this can be a string in quotes. eg \"2 mondays ago\""
	echo "	-e END DATE"
	echo "		end date (default today)"
	echo "		this can be a string in quotes. eg \"last friday\""
	echo "	-h"
	echo "		display this help and exit"
	echo
}

# determine start and end dates. default 'last monday' and 'today'. or pulled from opts
if [[ $(date +"%A") == "Monday" ]]
then
	S_DATE=$(date +"%Y%m%d")
else
	S_DATE=$(date --date="last monday" +"%Y%m%d")
fi

E_DATE=$(date +"%Y%m%d")

while getopts :hs:e: opt
do
	case $opt in
		s)
			S_DATE=$(date --date="$OPTARG" +"%Y%m%d")
			;;
		e)
			E_DATE=$(date --date="$OPTARG" +"%Y%m%d")
			;;
		h)
			show_help
			exit 0
			;;
		\?)
			echo "Invalid option -$OPTARG"
			echo "Try: '`basename $0` -h' for help"
			exit 1
			;;
	esac
done

echo $S_DATE			#TEST
echo $E_DATE			#TEST

#search files in range
for cdate in $(seq $S_DATE $E_DATE)
do
	if [[ $(echo ${cdate:6:2}) -gt 31 || $(echo ${cdate:6:2}) -lt 1 ]]
	then
		continue
	fi

	file="$(date --date="$cdate" +"%Y-%m-%d")-cehnstrom" 2>/dev/null
	year=$(date --date="$cdate" +"%Y") 2>/dev/null
	month=$(date --date="$cdate" +"%m") 2>/dev/null

	echo $file		#TEST
	echo $year		#TEST
	echo $month		#TEST

	
done
