#!/bin/bash

#generate an xkcdpass with numbers at either end

helpfunc(){
	echo "Usage: `basename $0` [option] ..."
	echo "-a acrostic"
	echo "-m max-length of words"
	echo "-h display help"
}

ACRO=""
MAX=""

while getopts :ha:m: opt
do
	case $opt in
		a)
			ACRO="-a $OPTARG"
			;;
		m)
			MAX="--max $OPTARG"
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

echo $(shuf -i 1000-9999 -n1)-$(xkcdpass -d_ -C random $ACRO $MAX)-$(shuf -i 1000-9999 -n1)
