#!/bin/bash

#func to grep field and paste to bc. arg1=search-string arg1=file                                                         
# grep hours for jobcode func. arg1=search-string 
gethours(){
        FUNC_HRS=0
	FUNC_HRS=$([ -n "$(grep $1 $2 | awk -F'|' '$4 {printf $4"+"}' | sed 's/+$//' | paste | bc)" ] && grep $1 $2 | awk -F'|' '$4 {printf $4"+"}' | sed 's/+$//' | paste | bc || echo 0)
	echo $1 $FUNC_HRS
}

FILE0="/home/imstof/Documents/2019-03-12-cehnstrom"
CODES="ENG C3 TS"

for code in $CODES
do
	gethours $code $FILE0
done



#gethours ENG $FILE0
#gethours C3 $FILE0
#gethours WTF $FILE0
#gethours "-v -e C3 -e ENG" $FILE0


