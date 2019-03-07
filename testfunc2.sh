#!/bin/bash

VARB=0

# arg1=search_string arg2=value_of_variable like "$variable"
testfunc(){
#	echo $1
#	echo $2
	TEMP=$2
	TEMP=$(echo $TEMP+1 | bc)
	echo $TEMP
}

echo before...
echo $VARB
VARB=$(
testfunc search-for-this "$VARB"
)
echo after!
echo $VARB

if [[ -n $VARB ]]
then
	echo yay
elif [[ $VARB -eq "1" ]]
then
	echo YAY

fi
