#!/bin/bash

#check if hours are archived in Documents/Hours-$year/$month/

help_func(){
	echo Usage: `basename $0` [OPTION] ...
	echo -e "\n  -y YEAR"
	echo "  -m MONTH"
	echo -e "  -h\n    print this help and exit"
}

YEAR=$(date +%Y)
MONTH=$(date +%m)

while getopts :hy:m: opt
do
	case $opt in
		y)
			if [[ -z "$(date -d 1/1/$OPTARG)" ]]
			then
				echo ERROR: Invalid year "$OPTARG" 1>&2
				help_func && exit 1
			else
				YEAR=$(date -d 1/1/$OPTARG +%Y)
			fi
			;;
		m)
			if [[ -z "$(date -d $OPTARG/1)" ]]
			then
				echo ERROR: Invalid month "$OPTARG" 1>&2
				help_func && exit 1
			else
				MONTH=$(date -d $OPTARG/1 +%m)
			fi
			;;
		h)
			echo "Check if hours are archived for a given month."
			help_func
			exit 0
			;;
		\?)
			echo "ERROR: Invalid option \"$OPTARG\"" 1>&2
			help_func
			exit 1
			;;
	esac
done
echo

for i in {01..31}
do
	if [[ -n "$(date -d $MONTH/$i 2>/dev/null)" ]]
	then
		if [[ -e ~/Documents/Hours-$YEAR/$MONTH/$YEAR-$MONTH-$i-cehnstrom ]]
		then
			echo -n "."
		else
			echo -e "\nFile for $(date -d $MONTH/$i/$YEAR +"%a %m/%d/%Y") is NOT ARCHIVED!"
		fi
	fi
done
echo
