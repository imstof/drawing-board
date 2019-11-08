#!/bin/bash

clean_up(){
        rm -r $TMPFILE
}

gethours(){
        echo $([ -n "$(grep $1 $2 | awk -F'|' '$4 {printf $4"+"}' | sed 's/+$//' | paste | bc)" ] && grep $1 $2 | awk -F'|' '$4 {printf $4"+"}' | sed 's/+$//' | paste | bc || echo 0)
}

trap clean_up EXIT TERM INT

S_DATE=20190319
E_DATE=20190321
OTHER_HOURS=0
TOTAL_HOURS=0
TMPFILE=$(mktemp /tmp/`basename $0`.XXX)

CODES="TS ENG NEURO C3 HPC HOLYOKE SPHHS CDS JP"
OTHER="-v -e HOME -e LUNCH -e TS -e ENG -e NEURO -e C3 -e HPC -e HOLYOKE -e SPHHS -e CDS -e JP"
echo $OTHER

for code in $CODES
do
	TMPHRS=0
	for tmpdate in $(seq $S_DATE $E_DATE)
	do
		[ -z "$(date -d $tmpdate 2>/dev/null)" ] && continue
		FILE0="/home/imstof/Documents/$(date -d $tmpdate +%Y-%m-%d)-cehnstrom"
		FILE1="/home/imstof/Documents/Hours-$(date -d $tmpdate +%Y)/$(date -d $tmpdate +%m)/$(date -d $tmpdate +%Y-%m-%d)-cehnstrom"
		[[ ! -e $FILE0 && ! -e $FILE1 ]] && echo "no file found for $(date -d $tmpdate +%Y-%m-%d)!" >> $TMPFILE && continue
		TMPHRS=$(echo $TMPHRS+$(
		[[ -e $FILE0 ]] && gethours $code $FILE0 || gethours $code $FILE1) | bc)
	done
	echo "$code hours = $TMPHRS"
	TOTAL_HOURS=$(echo $TOTAL_HOURS+$TMPHRS | bc)
done

for tmpdate in $(seq $S_DATE $E_DATE)
do
	[ -z "$(date -d $tmpdate 2>/dev/null)" ] && continue
	FILE0="/home/imstof/Documents/$(date -d $tmpdate +%Y-%m-%d)-cehnstrom"
	FILE1="/home/imstof/Documents/Hours-$(date -d $tmpdate +%Y)/$(date -d $tmpdate +%m)/$(date -d $tmpdate +%Y-%m-%d)-cehnstrom"
		[[ ! -e $FILE0 && ! -e $FILE1 ]] && echo "no file found for $(date -d $tmpdate +%Y-%m-%d)!" >> $TMPFILE && continue
	OTHER_HOURS=$(echo $OTHER_HOURS+$(
	[[ -e $FILE0 ]] && gethours "$OTHER" $FILE0 || gethours $(echo OTHER) $FILE1) | bc)
	TOTAL_HOURS=$(echo $TOTAL_HOURS+$OTHER_HOURS | bc)
done

echo OTHER HOURS = $OTHER_HOURS
echo TOTAL HOURS = $TOTAL_HOURS
echo errors from $TMPFILE
cat $TMPFILE
