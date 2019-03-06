#!/bin/bash

#Check to see if hours for all relevant days have been submitted on aquinas

echo "Confirm all hours are submitted"
echo "==============================="

#while true
#do
#	read -p "Enter yyyy-mm: " chdate
#	if [[ -z $chdate ]]
#	then
#		chdate=$(date +"%Y-%m")
#	fi
#	if [[ -n $chdate ]]
#	then
##work on year. auto or validate.
#		yr=${chdate:0:4}
#		if [[ ${chdate:5:1} -eq 0 ]]
#		then
#			mo=${chdate:6:1}
#		else
#			mo=${chdate:5:2}
#		fi
#
#		if [[ ${chdate:4:1} == "-" && $mo -gt 0 && $mo -lt 13 && $yr -gt 2015 ]]
#		then
#			break
#		fi
#	fi
#	echo "Invalid entry"
#done 



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

i=1
while [ $i -le $dayz ]
do
	if [[ $i -lt 10 ]]
	then
		dy=0$i
	else
		dy=$i
	fi
	valdate=$chdate-$dy

	if [[ $(date --date="$valdate" +"%a") != "Sat" && $(date --date="$valdate" +"%a") != "Sun" ]]
	then
		if [[ -e /projects/hours/$yr/$valdate-cehnstrom ]]
		then
			echo "checking "$valdate"-cehnstrom"
			chHours=$(cat /projects/hours/$yr/$valdate-cehnstrom | /projects/clients/bin/hoursvalid.pl)
			if [[ $chHours == "" ]]
			then
				echo "ok"
			else
				echo $(tput setaf 1)"ERROR"$(tput sgr 0)
			fi
		else
			echo $valdate"-cehnstrom is " $(tput setaf 1)"MISSING!"$(tput sgr 0)
		fi
	else
		if [[ -e /projects/hours/$yr/$valdate-cehnstrom ]]
		then
			echo "checking "$valdate"-cehnstrom" $(tput setaf 3)"WEEKEND"$(tput sgr 0)
			chHours=$(cat /projects/hours/$yr/$valdate-cehnstrom | /projects/clients/bin/hoursvalid.pl)
			if [[ $chHours == "" ]]
			then
				echo "ok"
			else
				echo $(tput setaf 1)"ERROR"$(tput sgr 0)
			fi
		fi
	fi

	((i++))
done
