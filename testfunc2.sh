#!/bin/bash

#func to grep field and paste to bc. arg1=search-string arg1=file                                                         
findhours(){
        grep $1 $2 | awk -F'|' '$4 {printf $4"+"}' | sed 's/+$//' | paste | bc
}

# grep hours for jobcode func. arg1=search-string 
gethours(){
        FUNC_HRS=0
	FUNC_HRS=$(findhours ENG $FILE0)
	echo $1 $FUNC_HRS
}

FILE0="/home/imstof/Documents/2019-03-12-cehnstrom"

#echo $FILE0
gethours ENG $FILE0
gethours C3 $FILE0


#grep ENG Documents/2019-03-12-cehnstrom | awk -F'|' '$4 {printf $4"+"}' | sed 's/+$//'
