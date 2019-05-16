#!/bin/bash

#generate an xkcdpass with numbers at either end

helpfunc(){
	echo "Usage: `basename $0` [option] ..."
	echo "-a acrostic"
	echo "-m max-length of words"
	echo "-l max-length of output"
	echo "-h display help"
}

ACRO=""
MAX=""

while getopts :ha:m:l: opt
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

PASS=$(echo $(shuf -i 1000-9999 -n1)-$(xkcdpass -d_ -C random $ACRO $MAX)-$(shuf -i 1000-9999 -n1))
if [[ -n $LEN ]]
then
	echo ${PASS:0:$LEN}
else
	echo $PASS
fi
