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

# determine start and end dates. default 'last monday' and 'today'. or pulled from opts
if [[ $(date +"%A") == "Monday" ]]
then
	S_DATE=$(date +"%Y%m%d")
else
	S_DATE=$(date --date="last monday" +"%Y%m%d")
fi

E_DATE=$(date +"%Y%m%d")
ENG_HOURS=0
C3_HOURS=0
NEURO_HOURS=0
HOLYOKE_HOURS=0
TS_HOURS=0

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

#echo $S_DATE			#TEST
#echo $E_DATE			#TEST

#validate data and set file variables
for cdate in $(seq $S_DATE $E_DATE)
do
#	if [[ $(echo $((10#${cdate:6:2}))) -gt 31 || $(echo $((10#${cdate:6:2}))) -lt 1 || -z $(echo $(date --date=$cdate 2>/dev/null)) ]]
	if [[ -z $(date --date=$cdate 2>/dev/null) ]]
	then
		continue
	fi

	FILE="$(date --date=$cdate +"%Y-%m-%d")-cehnstrom"
	YEAR=$(date --date=$cdate +"%Y")
	MONTH=$(date --date=$cdate +"%m")

	if [[ ! -e /home/imstof/Documents/$FILE && ! -e /home/imstof/Documents/Hours-$YEAR/$MONTH/$FILE ]]
	then
		continue
	fi

#	echo $FILE		#TEST
#	echo $YEAR		#TEST
#	echo $MONTH		#TEST

#grep FILE for hours
	if [[ -e /home/imstof/Documents/$FILE ]]
	then
		ENG_HOURS=$(echo $ENG_HOURS+$(
			if [[ -n $(cat /home/imstof/Documents/$FILE | grep ENG | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc) ]]
			then
				echo $(cat /home/imstof/Documents/$FILE | grep ENG | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc)
			else
				echo 0
			fi
						 ) | bc)
		C3_HOURS=$(echo $C3_HOURS+$(
			if [[ -n $(cat /home/imstof/Documents/$FILE | grep C3 | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc) ]]
			then
				echo $(cat /home/imstof/Documents/$FILE | grep C3 | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc)
			else
				echo 0
			fi
						 ) | bc)
		NEURO_HOURS=$(echo $NEURO_HOURS+$(
			if [[ -n $(cat /home/imstof/Documents/$FILE | grep NEURO | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc) ]]
			then
				echo $(cat /home/imstof/Documents/$FILE | grep NEURO | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc)
			else
				echo 0
			fi
						 ) | bc)

		HOLYOKE_HOURS=$(echo $HOLYOKE_HOURS+$(
			if [[ -n $(cat /home/imstof/Documents/$FILE | grep HOLYOKE | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc) ]]
			then
				echo $(cat /home/imstof/Documents/$FILE | grep HOLYOKE | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc)
			else
				echo 0
			fi
						 ) | bc)

		TS_HOURS=$(echo $TS_HOURS+$(
			if [[ -n $(cat /home/imstof/Documents/$FILE | grep TS | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc) ]]
			then
				echo $(cat /home/imstof/Documents/$FILE | grep TS | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc)
			else
				echo 0
			fi
						 ) | bc)
	else
		ENG_HOURS=$(echo $ENG_HOURS+$(
			if [[ -n $(cat /home/imstof/Documents/Hours-$YEAR/$MONTH/$FILE | grep ENG | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc) ]]
			then 
				echo $(cat /home/imstof/Documents/Hours-$YEAR/$MONTH/$FILE | grep ENG | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc)
			else
				echo 0
			fi
						) | bc)
		C3_HOURS=$(echo $C3_HOURS+$(
			if [[ -n $(cat /home/imstof/Documents/Hours-$YEAR/$MONTH/$FILE | grep C3 | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc) ]]
			then 
				echo $(cat /home/imstof/Documents/Hours-$YEAR/$MONTH/$FILE | grep C3 | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc)
			else
				echo 0
			fi
						) | bc)
		NEURO_HOURS=$(echo $NEURO_HOURS+$(
			if [[ -n $(cat /home/imstof/Documents/Hours-$YEAR/$MONTH/$FILE | grep NEURO | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc) ]]
			then 
				echo $(cat /home/imstof/Documents/Hours-$YEAR/$MONTH/$FILE | grep NEURO | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc)
			else
				echo 0
			fi
						) | bc)

		HOLYOKE_HOURS=$(echo $HOLYOKE_HOURS+$(
			if [[ -n $(cat /home/imstof/Documents/Hours-$YEAR/$MONTH/$FILE | grep HOLYOKE | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc) ]]
			then 
				echo $(cat /home/imstof/Documents/Hours-$YEAR/$MONTH/$FILE | grep HOLYOKE | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc)
			else
				echo 0
			fi
						) | bc)

		TS_HOURS=$(echo $TS_HOURS+$(
			if [[ -n $(cat /home/imstof/Documents/Hours-$YEAR/$MONTH/$FILE | grep TS | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc) ]]
			then 
				echo $(cat /home/imstof/Documents/Hours-$YEAR/$MONTH/$FILE | grep TS | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc)
			else
				echo 0
			fi
						) | bc)
	fi

#echo $ENG_HOURS			#TEST
#echo $C3_HOURS			#TEST
	
done

echo ENGAGING HOURS = $ENG_HOURS
echo C3DDB HOURS = $C3_HOURS
echo NEURO HOURS = $NEURO_HOURS
echo HOLYOKE_HOURS = $HOLYOKE_HOURS
echo TS_HOURS = $TS_HOURS
