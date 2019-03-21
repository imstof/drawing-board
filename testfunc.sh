#!/bin/bash

clean_up(){
        rm -r $TMPFILE
}

gethours(){
echo $1 >> $TMPFILE
echo $2 >> $TMPFILE
        echo $([ -n "$(grep $1 $2 | awk -F'|' '$4 {printf $4"+"}' | sed 's/+$//' | paste | bc)" ] && grep $1 $2 | awk -F'|' '$4 {printf $4"+"}' | sed 's/+$//' | paste | bc || echo 0)
}

trap clean_up EXIT TERM INT

S_DATE=20190312
E_DATE=20190313
OTHER_HOURS=0
TOTAL_HOURS=0
TMPFILE=$(mktemp /tmp/`basename $0`.XXX)

#declare -a CODES="TS ENG NEURO C3 HPC HOLYOKE SPHHS CDS JP"
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
#		[[ ! -e $FILE0 && ! -e $FILE1 ]] && echo "no file found for $(date -d $tmpdate +%Y-%m-%d)!" >> $TMPFILE && continue
		[[ ! -e $FILE0 && ! -e $FILE1 ]] && continue
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
#		[[ ! -e $FILE0 && ! -e $FILE1 ]] && echo "no file found for $(date -d $tmpdate +%Y-%m-%d)!" >> $TMPFILE && continue
	[[ ! -e $FILE0 && ! -e $FILE1 ]] && continue
	gethours "$OTHER" $FILE0
#	OTHER_HOURS=$(echo $OTHER_HOURS+$(
#	[[ -e $FILE0 ]] && gethours $(echo $OTHER) $FILE0 || gethours $(echo OTHER) $FILE1) | bc)
	TOTAL_HOURS=$(echo $TOTAL_HOURS+$OTHER_HOURS | bc)
done

echo OTHER HOURS = $OTHER_HOURS
echo TOTAL HOURS = $TOTAL_HOURS
echo errors from $TMPFILE
cat $TMPFILE

#echo $TS_HOURS
#
#for code in $CODES
#do
#	echo "${code}_HOURS"
#done

#for code in $CODES
#do
#	echo $code $(gethours $code $FILE0)
#	declare ${code}_HOURS=$(gethours $code $FILE0)
#	echo $(${code}_HOURS)
#done

#test here...
#gethours TS /home/imstof/Documents/2019-03-12-cehnstrom
