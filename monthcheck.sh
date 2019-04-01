#!/bin/bash

#imstof 3/29/19 rewrite
#check if hours are submitted for given month

#help
help_func(){
	echo "Usage: `basename $0` [option] ..."
	echo
	echo "  -m [month-to-check]"
	echo "	(default = current month)"
	echo
	echo "  -h"
	echo "	display this help and exit"
}

DATE_IN=$(date -d $(date +%m)/1 +%Y%m%d)
#check if dates are valid and set month/year variables
while getopts :hm: opt
do
	case $opt in
		m)
			if [[ -z "$(echo $OPTARG/1 | xargs date -d 2>/dev/null)" ]]
			then
				echo ERROR: invalid date "$OPTARG" 1>&2
				help_func && exit 1
			elif [[ "$OPTARG" -gt "$(date +%m)" ]]
			then
				DATE_IN=$(date -d $OPTARG/1/$(date -d "last year" +%Y) +%Y%m%d)
			else
				DATE_IN=$(date -d $OPTARG/1 +%Y%m%d)
			fi
			;;
		h)
			echo check if hours are properly submitted for a given month
			help_func
			exit 0
			;;
		\?)
			echo ERROR: invalid option "-$OPTARG" 1>&2
			help_func && exit 1
			;;
	esac
done

#echo $DATE_IN	#test

#cycle through dates until end-of-month
while [[ -n "$(date -d $DATE_IN 2>/dev/null)" ]]
do
	if [[ -e /projects/hours/$(date -d $DATE_IN +%Y)/$(date -d $DATE_IN +%Y-%m-%d)-cehnstrom ]]
	then
		((DATE_IN++))
	else
		echo Hours for $(date -d $DATE_IN +"%a %m/%d") are not submitted.
		((DATE_IN++))
	fi
done
