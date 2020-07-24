#!/bin/bash

#doy minus zeroes
TODAY=$(date +%j)
while [[ ${TODAY:0:1} = 0 ]];do TODAY=${TODAY:1};done
#days in year being calculated, checked for leap year
DYEAR=$(date -d 12/31/$(date -d "next year" +%y) +%j)
#doy birthdays minus 0s
#isabel
[[ $(date -d 6/24 +%j) -ge $TODAY ]] && IBDAY=$(date -d 6/24 +%j) || IBDAY=$(date -d 6/24/$(date -d "next year" +%y) +%j)
#theo
M25=$(date -d 3/25 +%j);while [[ ${M25:0:1} = 0 ]];do M25=${M25:1};done
#echo $M25			#TEST
[[ $M25 -ge $TODAY ]] && TBDAY=$M25 || TBDAY=$(date -d 3/25/$(date -d "next year" +%y) +%j);while [[ ${TBDAY:0:1} = 0 ]];do TBDAY=${TBDAY:1};done

echo DYEAR=$DYEAR		#TEST
echo TODAY=$TODAY		#TEST
echo IBDAY=$IBDAY		#TEST
echo TBDAY=$TBDAY		#TEST


