#!/bin/bash

# check hours worked on project codes

# help func
show_help (){
	echo
	echo "Usage: `basename $0` [option] ..."
	echo "Report of hours worked on projects"
	echo
	echo "	-s START_DATE"
	echo "		start date (default Monday)"
	echo "		this can be a string in quotes. eg \"2 mondays ago\""
	echo "	-e END_DATE"
	echo "		end date (default today)"
	echo "	-h"
	echo "		display this help and exit"
	echo
}

if [[ $(date +"%A") == "Monday" ]]
then
	START_DATE=$(date +"%Y-%m-%d")
else
	START_DATE=$(date --date="last monday" +"%Y-%m-%d")
fi

END_DATE=$(date +"%Y-%m-%d")

while getopts :hs:e: opts
do
	case $opt in
		s)
			START_DATE=$(date --date="$OPTARG")
			;;
		e)
			END_DATE=$(date --date="$OPTARG")
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


