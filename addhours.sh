#!/bin/bash
#Find sum of hours worked on given client for given timeframe

#thisyear=$(date +"%Y")

#prompt for input
echo ""
echo "Find sum of hours worked on given client"
echo "========================================"
echo ""
#check host. If aquinas use project/hours/ directory M-today, else prompt
if [ $HOSTNAME = "planetaquinas" ]
then
	echo "You are on" $HOSTNAME
	echo "You will search /projects/hours/$(date +"%Y")"
	echo "Default start/end dates are:"
	echo "Start: " $(date --date="last monday" +"%Y-%m-%d")
	echo "End: " $(date +"%Y-%m-%d")
	dir=/projects/hours/$(date +"%Y")/
	sdate=$(date --date="last monday" +"%Y-%m-%d")
	edate=$(date +"%Y-%m-%d")

else  #Get dir, start, and end dates. If ~/Documents use today
	read -p "This week's cluster hours?: " yn
	if [ ${yn:0:1} == "y" ] || [ ${yn:0:1} == "Y" ]
	then
		sdate=$(date --date="last monday" +"%Y-%m-%d")
		edate=$(date +"%Y-%m-%d")
		dir=~/Documents/Hours-$(date +"%Y")/$(date +"%m")/
		if [ -e ~/Documents/$edate-cehnstrom ]
		then
			cat ~/Documents/$edate-cehnstrom | awk -F "|" '/ENGAGING/ {print $4;}' >> ~/Documents/temphours
			cat ~/Documents/$edate-cehnstrom | awk -F "|" '/C3DDB/ {print $4;}' >> ~/Documents/temphours
			for file in $dir*; do
				file2=$(echo $file | cut -d'/' -f7 | cut -d'-' -f1-3)
				if [[ $(echo $file2) == $(echo $sdate)  ||  $(echo $file2) > $(echo $sdate)  &&  $(echo $file2) < $(echo $edate) ]]
				then
					cat $file | awk -F "|" '/ENGAGING/ {print $4;}' >> ~/Documents/temphours
					cat $file | awk -F "|" '/C3DDB/ {print $4;}' >> ~/Documents/temphours
				fi
			done
		else
			for file in $dir*; do
				if [ $(echo $file2) == $(echo $sdate) ] || [ $(echo $file2) > $(echo $sdate) ]
				then
					cat $file | awk -F "|" '/ENGAGING/ {print $4;}' >> ~/Documents/temphours
					cat $file | awk -F "|" '/C3DDB/ {print $4;}' >> ~/Documents/temphours
				fi
			done
		fi
	cat ~/Documents/temphours  #test
	sed '/^$/d' ~/Documents/temphours > ~/Documents/temphours
	cat ~/Documents/temphours  #test
	echo "Total cluster hours = "$(paste -sd+ ~/Documents/temphours | bc)
	#rm ~/Documents/temphours
		
	else
		echo "Enter directory to search"
		echo "Default is ~/Documents/ searching $(date +"%Y-%m-%d")"
		read -e -p "Directory: " dir
	fi

	if [ -z "$dir" ]
	then
		dir=~/Documents
		sdate=$(date +"%Y-%m-%d")
		edate=$(date +"%Y-%m-%d")
	else
		echo -n "Enter start date (YYYY-MM-DD)(default is Monday): "
		read sdate
		if [ -z "$sdate" ]
		then
			sdate=$(date --date="last monday" +"%Y-%m-%d")
		fi
		echo -n "Enter end date (YYYY-MM-DD)(default is today): "
		read edate
		if [ -z "$edate" ]
		then
			edate=$(date +"%Y-%m-%d")
		fi
	fi
fi

# Get files, cut and sum cluster hours

