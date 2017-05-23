#!/bin/bash

#figuring out getopts
#and test function

what_the_func() {
	echo "This is a function.
One day it might grow up to be a help file."
exit 0
}


TEXTONLY=false

while getopts :ht opt
do
	case $opt in
	  t)
	    TEXTONLY=true
	  ;;
	  h)
	    what_the_func
	  ;;
	  \?)
	    echo "Invalid option: -$OPTARG" >&2
	    exit 0
	  ;;
	esac
done

if [ $TEXTONLY == true ]
then
	echo "I print text!"
else
	echo "I email"
fi
