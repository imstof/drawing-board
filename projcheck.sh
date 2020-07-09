#!/bin/bash 
# check hours worked on project codes

# cleanup func and trap
cleanup(){
	rm -r $TMPFILE0
	rm -r $TMPFILE1
}
trap cleanup EXIT TERM INT

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
	echo "  -d CHECK DATE"
	echo "		check hours for only this date"
	echo "	-h"
	echo "		display this help and exit"
	echo
}

# grep hours for jobcode func. arg1=search-string arg2=file
gethours(){
        echo $([ -n "$(grep $1 $2 | awk -F'|' '$4 {printf $4"+"}' | sed 's/+$//' | paste | bc)" ] && grep $1 $2 | awk -F'|' '$4 {printf $4"+"}' | sed 's/+$//' | paste | bc || echo 0)
}

#other_hours func that sends code to FILE1
getother(){
        echo $([ -n "$(grep $1 $2 | tee -a $TMPFILE1 | awk -F'|' '$4 {printf $4"+"}' | sed 's/+$//' | paste | bc)" ] && grep $1 $2 | tee -a $TMPFILE1 | awk -F'|' '$4 {printf $4"+"}' | sed 's/+$//' | paste | bc || echo 0)
}

#S_DATE last monday
[ $(date +%A) == "Monday" ] && S_DATE=$(date +%Y%m%d) || S_DATE=$(date -d "last monday" +%Y%m%d)

E_DATE=$(date +%Y%m%d)
CODES="TS ENG NEURO C3 HPC HOLYOKE SPHHS CDS JP SATORI PTO"
OTHER="-v -e HOME -e LUNCH -e TS -e ENG -e NEURO -e C3 -e HPC -e HOLYOKE -e SPHHS -e CDS -e JP -e SATORI -e PTO"
OTHER_HOURS=0 
TOTAL_HOURS=0
TMPFILE0=$(mktemp /tmp/`basename $0`.XXX)
TMPFILE1=$(mktemp /tmp/`basename $0`.XXX)

while getopts :hs:e:d: opt
do
	case $opt in
		s)
			S_DATE=$(date -d "$OPTARG" +%Y%m%d 2>/dev/null)
			if [ -z $S_DATE ]
			then
				echo
				echo -n "Invalid date \"$OPTARG\"" 1>&2
				show_help
				exit 1
			fi
			;;
		e)
			E_DATE=$(date -d "$OPTARG" +%Y%m%d 2>/dev/null)
			if [ -z $E_DATE ]
			then
				echo
				echo -n "Invalid date \"$OPTARG\"" 1>&2
				show_help
				exit 1
			fi
			;;
		d)
			S_DATE=$(date -d "$OPTARG" +%Y%m%d 2>/dev/null)
			E_DATE=$(date -d "$OPTARG" +%Y%m%d 2>/dev/null)
			if [ -z $E_DATE ]
			then
				echo
				echo -n "Invalid date \"$OPTARG\"" 1>&2
				show_help
				exit 1
			fi
			;;
		h)
			show_help
			exit 0
			;;
		\?)
			echo "Invalid option -$OPTARG" 1>&2
			echo "Try: '`basename $0` -h' for help"
			exit 1
			;;
	esac
done

#loop through codes
for code in $CODES
do
	TMPHRS=0
	for tmpdate in $(seq $S_DATE $E_DATE)
	do
		#validate dates and set file variables
		[ -z "$(date -d $tmpdate 2>/dev/null)" ] && continue
		FILE0="/home/imstof/Documents/$(date -d $tmpdate +%Y-%m-%d)-cehnstrom"
		FILE1="/home/imstof/Documents/Hours-$(date -d $tmpdate +%Y)/$(date -d $tmpdate +%m)/$(date -d $tmpdate +%Y-%m-%d)-cehnstrom"

		#report missing files for date
		[[ ! -e $FILE0 && ! -e $FILE1 ]] && echo "no file found for $(date -d $tmpdate +%a,%Y-%m-%d)!" >> $TMPFILE0 && continue
		#check working file first, else check records
		TMPHRS=$(echo $TMPHRS+$(
		[[ -e $FILE0 ]] && gethours $code $FILE0 || gethours $code $FILE1) | bc)
	done
	echo "$code hours = $TMPHRS"
	TOTAL_HOURS=$(echo $TOTAL_HOURS+$TMPHRS | bc)
done

#get OTHER hours
for tmpdate in $(seq $S_DATE $E_DATE)
do
	[ -z "$(date -d $tmpdate 2>/dev/null)" ] && continue
	FILE0="/home/imstof/Documents/$(date -d $tmpdate +%Y-%m-%d)-cehnstrom"
	FILE1="/home/imstof/Documents/Hours-$(date -d $tmpdate +%Y)/$(date -d $tmpdate +%m)/$(date -d $tmpdate +%Y-%m-%d)-cehnstrom"
		[[ ! -e $FILE0 && ! -e $FILE1 ]] && continue
	OTHER_HOURS=$(echo $OTHER_HOURS+$(
	[[ -e $FILE0 ]] && getother "$OTHER" $FILE0 || getother "$OTHER" $FILE1) | bc)
done
TOTAL_HOURS=$(echo $TOTAL_HOURS+$OTHER_HOURS | bc)

echo OTHER HOURS = $OTHER_HOURS
echo
echo TOTAL HOURS = $TOTAL_HOURS
[[ -s $TMPFILE1 ]] && [[ -n $(cut -d'|' -f5 $TMPFILE1) ]] && (echo;echo Other Hours:;cat $TMPFILE1 | sed '/||/d' | sort -t'|' -k 2 -u)
[[ -s $TMPFILE0 ]] && (echo;echo Missing Files:;cat $TMPFILE0 | sort -t'-' -k 3 | uniq)
