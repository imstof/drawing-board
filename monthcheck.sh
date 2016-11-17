#!/bin/bash

#Check to see if hours for all relevant days have been submitted on aquinas

echo "Confirm all hours are submitted"
echo "==============================="

while true
do
	read -p "Enter mm-yyyy: " chdate
	if [[ -n $chdate ]]
	then
#work on year. auto or validate.
		yr=${chdate:3:4}
		if [[ ${chdate:0:1} -eq 0 ]]
		then
			mo=${chdate:1:1}
		else
			mo=${chdate:0:2}
		fi

		if [[ ${chdate:2:1} == "-" && $mo -gt 0 && $mo -lt 13 && $yr -gt 2015 ]]
		then
			break
		fi
	fi
	echo "Invalid entry"
done 

case $mo in
	1|3|5|7|8|10|12)
	 dayz=31
	;;
	4|6|9|11)
	 dayz=30
	;;
	2)
	 dayz=28
	;;
esac

i=
