#!/bin/bash

clean_up(){
        rm -r $TMPFILE
}

gethours(){
        echo $([ -n "$(grep $1 $2 | awk -F'|' '$4 {printf $4"+"}' | sed 's/+$//' | paste | bc)" ] && grep $1 $2 | awk -F'|' '$4 {printf $4"+"}' | sed 's/+$//' | paste | bc || echo 0)
}

trap clean_up EXIT TERM INT

S_DATE=20190312
E_DATE=20190313
TOTAL_HOURS=0
TMPFILE=$(mktemp /tmp/`basename $0`.XXX)

#declare -a CODES="TS ENG NEURO C3 HPC HOLYOKE SPHHS CDS JP"
CODES="TS ENG NEURO C3 HPC HOLYOKE SPHHS CDS JP"

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
	echo "$code HOURS = $TMPHRS"
	TOTAL_HOURS=$(echo $TOTAL_HOURS+$TMPHRS | bc)
done

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
gethours TS /home/imstof/Documents/2019-03-12-cehnstrom
