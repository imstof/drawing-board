#!/bin/bash
#Find sum of hours worked on given client for given timeframe

sdate=$(date --date="last monday" +"%Y-%m-%d")
edate=$(date +"%Y-%m-%d")

#prompt for input
echo ""
echo "  Total hours worked on ENGAGING/C3DDB"
echo "========================================"
echo ""
#check host. If aquinas use project/hours/ directory M-today, else prompt
if [ $HOSTNAME = "planetaquinas" ]
then
	echo "You are on" $HOSTNAME
	echo "You will search /projects/hours/$(date +"%Y")"
	echo "Start: " $(date --date="last monday" +"%Y-%m-%d")
	echo "End: " $(date +"%Y-%m-%d")
	dir=/projects/hours/$(date +"%Y")/

	for file in $dir*; do
		if [ $(echo $file | cut -d'/' -f5 | cut -d'-' -f4) == "cehnstrom" ]
		then
		
			fdate=$(echo $file | cut -d'/' -f7 | cut -d'-' -f1-3)
			if [ $(echo $fdate) == $(echo $sdate) ] || [ $(echo $fdate) > $(echo $sdate) ]
			then
				cat $file | awk -F "|" '/ENGAGING/ {print $4;}' >> ~/Documents/temphours
				cat $file | awk -F "|" '/C3DDB/ {print $4;}' >> ~/Documents/temphours
			fi
		fi
	done

else  #If other host, use personal records
	dir=~/Documents/Hours-$(date +"%Y")/$(date +"%m")/
	if [ -e ~/Documents/$edate-cehnstrom ]
	then
		cat ~/Documents/$edate-cehnstrom | awk -F "|" '/ENGAGING/ {print $4;}' >> ~/Documents/temphours
		cat ~/Documents/$edate-cehnstrom | awk -F "|" '/C3DDB/ {print $4;}' >> ~/Documents/temphours
		for file in $dir*; do
			fdate=$(echo $file | cut -d'/' -f7 | cut -d'-' -f1-3)
			if [[ $(echo $fdate) == $(echo $sdate)  ||  $(echo $fdate) > $(echo $sdate)  &&  $(echo $fdate) < $(echo $edate) ]]
			then
				cat $file | awk -F "|" '/ENGAGING/ {print $4;}' >> ~/Documents/temphours
				cat $file | awk -F "|" '/C3DDB/ {print $4;}' >> ~/Documents/temphours
			fi
		done
	else
		for file in $dir*; do
			if [ $(echo $fdate) == $(echo $sdate) ] || [ $(echo $fdate) > $(echo $sdate) ]
			then
				cat $file | awk -F "|" '/ENGAGING/ {print $4;}' >> ~/Documents/temphours
				cat $file | awk -F "|" '/C3DDB/ {print $4;}' >> ~/Documents/temphours
			fi
		done
	fi
fi

#cat ~/Documents/temphours  #test
sed '/^$/d' ~/Documents/temphours > ~/Documents/temphours2
#echo ""   #test
#cat ~/Documents/temphours2  #test
echo "               "$(paste -sd+ ~/Documents/temphours2 | bc)
rm ~/Documents/temphours*
