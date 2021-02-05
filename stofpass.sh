#!/bin/bash

#generate an xkcdpass with numbers at either end

helpfunc(){
	echo "Usage: `basename $0` [option] ..."
	echo "-a acrostic"
	echo "-m max-length of words"
	echo "-l max-length of output"
	echo "-c use alternate special characters"
	echo "-h display help"
}

ACRO=""
MAX=""
ALT=""

while getopts :hca:m:l: opt
do
	case $opt in
		a)
			ACRO="-a $OPTARG"
			;;
		m)
			MAX="--max $OPTARG"
			;;
		l)
			LEN="$OPTARG"
			;;
		c)
			ALT="yes"
			;;
		h)
			echo "generate an xkcd password with numbers"
			helpfunc && exit 0
			;;
		\?)
			echo "ERROR: invalid option -$OPTARG"
			helpfunc && exit 1
			;;
	esac
done

if [[ -z $ALT ]]
then
	PASS=$(echo $(shuf -i 1000-9999 -n1)-$(xkcdpass -d_ -C random $ACRO $MAX)-$(shuf -i 1000-9999 -n1))
else
	PASS=$(echo $(shuf -i 1000-9999 -n1)^$(xkcdpass -d* -C random $ACRO $MAX)^$(shuf -i 1000-9999 -n1))
fi

if [[ -n $LEN ]]
then
	echo ${PASS:2:$LEN}
else
	echo $PASS
fi
