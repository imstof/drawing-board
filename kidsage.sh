#!/bin/bash

#doy minus zeroes
TODAY=$(date +%j)
while [[ ${TODAY:0:1} = 0 ]];do TODAY=${TODAY:1};done
#days in years for calculation (last/this/next), checked for leap year
LYEAR=$(date -d 12/31/$(date -d "last year" +%y) +%j)
TYEAR=$(date -d 12/31/$(date +%y) +%j)
NYEAR=$(date -d 12/31/$(date -d "next year" +%y) +%j)

#doy birthdays minus 0s
#isabel
[[ $(date -d 6/24 +%j) -ge $TODAY ]] && IBDAY=$(date -d 6/24 +%j) && IYEARS=$(echo $(date -d "last year" +%Y)-2012 | bc) || (IBDAY=$(date -d 6/24/$(date -d "next year" +%y) +%j) && IYEARS=$(echo $(date +%Y)-2012 | bc))

#theo
#first reduce 0s from date
M25=$(date -d 3/25 +%j);while [[ ${M25:0:1} = 0 ]];do M25=${M25:1};done
#echo $M25			#TEST
[[ $M25 -ge $TODAY ]] && TBDAY=$M25 && TYEARS=$(echo $(date -d "last year" +%Y)-2015 | bc) || (TBDAY=$(date -d 3/25/$(date -d "next year" +%y) +%j) && TYEARS=$(echo $(date +%Y)-2015 | bc ));while [[ ${TBDAY:0:1} = 0 ]];do TBDAY=${TBDAY:1};done

#echo LYEAR=$LYEAR		#TEST
#echo TYEAR=$TYEAR		#TEST
#echo NYEAR=$NYEAR		#TEST
#echo TODAY=$TODAY		#TEST
#echo IBDAY=$IBDAY		#TEST
#echo IYEARS=$IYEARS		#TEST
#echo TBDAY=$TBDAY		#TEST
#echo TYEARS=$TYEARS		#TEST

#calculate
#isabel
[[ $TODAY -le $(date -d 6/24 +%j) ]] && IAGE=$(echo $IYEARS+\(\(190+$TODAY\)/$TYEAR\) | bc -l ) || IAGE=$(echo $IYEARS+\(\($TODAY-$IBDAY\)/$TYEAR\) | bc -l )

[[ $TODAY -le $M25 ]] && TAGE=$(echo $TYEARS+\(\(281+$TODAY\)/$TYEAR\) | bc -l) || TAGE=$(echo $TYEARS+\(\($TODAY-$TBDAY\)/$TYEAR\) | bc -l )

#report
echo Isabel is $IAGE years old
echo Theo is $TAGE years old

echo Ladies and gentlemen... my ${IAGE:0:10} year-old.
echo Ladies and gentlemen... my ${TAGE:0:10} year-old.
