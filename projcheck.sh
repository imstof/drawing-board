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

# grep hours for jobcode func. arg1=search-string arg2=file
gethours(){
	FUNC_HRS=0
	        FUNC_HRS=$([ -n "$(grep $1 $2 | awk -F'|' '$4 {printf $4"+"}' | sed 's/+$//' | paste | bc)" ] && grep $1 $2 | awk -F'|' '$4 {printf $4"+"}' | sed 's/+$//' | paste | bc || echo 0)
	echo $FUNC_HRS
}

[ $(date +%A) == "Monday" ] && S_DATE=$(date +%Y%m%d) || S_DATE=$(date -d "last monday" +%Y%m%d)

E_DATE=$(date +%Y%m%d)

TS_HOURS=0
ENG_HOURS=0
NEURO_HOURS=0
C3_HOURS=0
HPC_HOURS=0
HOLYOKE_HOURS=0
SPHHS_HOURS=0
CDS_HOURS=0
JP_HOURS=0

# testing variables...
#CODES="TS ENG NEURO C3 HPC HOLYOKE SPHHS CDS JP"
#for code in $CODES
#do
#	$code_HOURS=0
#done

OTHER_HOURS=0 
while getopts :hs:e: opt
do
	case $opt in
		s)
			S_DATE=$(date -d "$OPTARG" +%Y%m%d 2>/dev/null)
			if [ -z $S_DATE ]
			then
				echo
				echo -n "Invalid date \"$OPTARG\""
				show_help
				exit 1
			fi
			;;
		e)
			E_DATE=$(date -d "$OPTARG" +%Y%m%d 2>/dev/null)
			if [ -z $E_DATE ]
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

#debugging here...
#echo $S_DATE
#echo $E_DATE
#echo made it here 0

#validate data and set file variables
for cdate in $(seq $S_DATE $E_DATE)
do
	[ -z "$(date -d $cdate 2>/dev/null)" ] && continue

	FILE0="/home/imstof/Documents/$(date -d $cdate +%Y-%m-%d)-cehnstrom"
	FILE1="/home/imstof/Documents/Hours-$(date -d $cdate +%Y)/$(date -d $cdate +%m)/$(date -d $cdate +%Y-%m-%d)-cehnstrom"
	

	[[ ! -e $FILE0 && ! -e $FILE1 ]] && echo no file found for $(date -d $cdate +%Y-%m-%d)! && continue

#debugging here...
#echo $FILE0
#echo $FILE1
#echo made it here 1

[ -e $FILE0 ] && TS_HOURS=$(echo $TS_HOURS+$(gethours TS $FILE0) | bc) || TS_HOURS=$(echo $TS_HOURS+$(gethours TS $FILE1) | bc)

#TS_HOURS=$(echo $TS_HOURS+$(gethours TS $FILE0) | bc)
#ENG_HOURS=$(echo $ENG_HOURS+$(gethours ENG $FILE0) | bc)
#NEURO_HOURS=$(echo $NEURO_HOURS+$(gethours NEURO $FILE0) | bc)
#C3_HOURS=$(echo $C3_HOURS+$(gethours C3 $FILE0) | bc)
#HPC_HOURS=$(echo $HPC_HOURS+$(gethours HPC $FILE0) | bc)
#HOLYOKE_HOURS=$(echo $HOLYOKE_HOURS+$(gethours HOLY $FILE0) | bc)
#SPHHS_HOURS=$(echo $SPHHS_HOURS+$(gethours SPHHS $FILE0) | bc)
#CDS_HOURS=$(echo $CDS_HOURS+$(gethours CDS $FILE0) | bc)
#JP_HOURS=$(echo $JP_HOURS+$(gethours JP $FILE0) | bc)
#debugging here...
#echo made it here 2
OTHER_HOURS=$(echo $OTHER_HOURS+$(gethours "-v -e ENG -e C3 -e HPC -e NEURO -e HOLY -e SPHHS -e CDS -e TS -e LUNCH -e HOME" $FILE0) | bc)

#debugging here...
#echo made it here 3

done

echo TS_HOURS = $TS_HOURS
echo ENGAGING HOURS = $ENG_HOURS
echo C3DDB HOURS = $C3_HOURS
echo HPC_HOURS = $HPC_HOURS
echo NEURO HOURS = $NEURO_HOURS
echo HOLYOKE_HOURS = $HOLYOKE_HOURS
echo SPHHS_HOURS = $SPHHS_HOURS
echo CDS_HOURS = $CDS_HOURS
echo JP_HOURS = $JP_HOURS
echo OTHER_HOURS = $OTHER_HOURS
echo
echo TOTAL_HOURS = $(echo $ENG_HOURS+$C3_HOURS+$HPC_HOURS+$NEURO_HOURS+$HOLYOKE_HOURS+$SPHHS_HOURS+$CDS_HOURS+$OTHER_HOURS+$TS_HOURS | bc)
