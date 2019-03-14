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
	echo "		this can be a string in quotes. eg \"last tuesday\""
	echo "	-e END DATE"
	echo "		end date (default today)"
	echo "		this can be a string in quotes. eg \"last friday\""
	echo "	-h"
	echo "		display this help and exit"
	echo
}

#func to grep field and paste to bc. arg1=search-string arg1=file
findhours(){
	grep $1 $2 | awk -F '$4 {printf $4"+"}' | sed 's/+$//' | paste | bc
}

# grep hours for jobcode func. arg1=search-string 
gethours(){
	FUNC_HRS=0
#	if [[ -e $FILE0 ]]
#	then
#		if [[ -n $(cat $FILE0 | grep $1 | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc) ]]
#		then
#			FUNC_HRS=$(echo $FUNC_HRS+$(echo $(cat $FILE0 | grep $1 | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc)) | bc)
#		fi
#	elif [[ -n $(cat $FILE1 | grep $1 | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc) ]]
#		then
#			FUNC_HRS=$(echo $FUNC_HRS+$(echo $(cat $FILE1 | grep $1 | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc)) | bc)
#	fi
	echo $FUNC_HRS
}

#only echo hours if non-zero func. arg1=hours_variable
#showhours(){
#	
#}

# determine start and end dates. default 'last monday' and 'today'. or pulled from opts
#if [[ $(date +"%A") == "Monday" ]]
#then
#	S_DATE=$(date +"%Y%m%d")
#else
#	S_DATE=$(date --date="last monday" +"%Y%m%d")
#fi
[[ $(date +"%A") == "Monday" ]] && S_DATE=$(date +"%Y%m%d") || S_DATE=$(date --date="last monday" +"%Y%m%d")

E_DATE=$(date +"%Y%m%d")

TS_HOURS=0
ENG_HOURS=0
NEURO_HOURS=0
C3_HOURS=0
HPCHELP_HOURS=0
HOLYOKE_HOURS=0
SPHHS_HOURS=0
CDS_HOURS=0
JP_HOURS=0
OTHER_HOURS=0 
while getopts :hs:e: opt
do
	case $opt in
		s)
			S_DATE=$(date --date="$OPTARG" +"%Y%m%d" 2>/dev/null)
			if [[ -z $S_DATE ]]
			then
				echo
				echo -n "Invalid date \"$OPTARG\""
				show_help
				exit 1
			fi
			;;
		e)
			E_DATE=$(date --date="$OPTARG" +"%Y%m%d" 2>/dev/null)
			if [[ -z $E_DATE ]]
			then
				echo
				echo -n "Invalid date \"$OPTARG\""
				show_help
				exit 1
			fi
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

#validate data and set file variables
for cdate in $(seq $S_DATE $E_DATE)
do
	if [[ -z $(date --date=$cdate 2>/dev/null) ]]
	then
		continue
	fi

	FILE0="/home/imstof/Documents/$(date --date=$cdate +"%Y-%m-%d")-cehnstrom"
	FILE1="/home/imstof/Documents/Hours-$(date --date=$cdate +"%Y")/$(date --date=$cdate +"%m")/$(date --date=$cdate +"%Y-%m-%d")-cehnstrom"
	

	if [[ ! -e $FILE0 && ! -e $FILE ]]
	then
		echo no file found for $(date --date=$cdate +"%Y-%m-%d")!
		continue
	fi

TS_HOURS=$(echo $TS_HOURS+$(gethours TS) | bc)
ENG_HOURS=$(echo $ENG_HOURS+$(gethours ENG) | bc)
NEURO_HOURS=$(echo $NEURO_HOURS+$(gethours NEURO) | bc)
C3_HOURS=$(echo $C3_HOURS+$(gethours C3) | bc)
HPCHELP_HOURS=$(echo $HPCHELP_HOURS+$(gethours HELP) | bc)
HOLYOKE_HOURS=$(echo $HOLYOKE_HOURS+$(gethours HOLY) | bc)
SPHHS_HOURS=$(echo $SPHHS_HOURS+$(gethours SPHHS) | bc)
CDS_HOURS=$(echo $CDS_HOURS+$(gethours CDS) | bc)
JP_HOURS=$(echo $JP_HOURS+$(gethours JP) | bc)
OTHER_HOURS=$(echo $OTHER_HOURS+$(gethours "-v -e ENG -e C3 -e HELP -e NEURO -e HOLY -e SPHHS -e CDS -e TS -e LUNCH -e HOME") | bc)

done

echo TS_HOURS = $TS_HOURS
echo ENGAGING HOURS = $ENG_HOURS
echo C3DDB HOURS = $C3_HOURS
echo HPCHELP_HOURS = $HPCHELP_HOURS
echo NEURO HOURS = $NEURO_HOURS
echo HOLYOKE_HOURS = $HOLYOKE_HOURS
echo SPHHS_HOURS = $SPHHS_HOURS
echo CDS_HOURS = $CDS_HOURS
echo JP_HOURS = $JP_HOURS
echo OTHER_HOURS = $OTHER_HOURS
echo
echo TOTAL_HOURS = $(echo $ENG_HOURS+$C3_HOURS+$HPCHELP_HOURS+$NEURO_HOURS+$HOLYOKE_HOURS+$SPHHS_HOURS+$CDS_HOURS+$OTHER_HOURS+$TS_HOURS | bc)
