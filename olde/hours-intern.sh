#1 bin/bash

#A script to enter hours

#Prompt for input
echo -n "Start Time (HH:mm): "
read staht
echo -n "End Time (HH:mm): "
read end

#Parse input (force decimal)
sthr=$((10#${staht:0:2}))
stmin=${staht:3:2}
endhr=$((10#${end:0:2}))
endmin=${end:3:2}
#Figure out data validation for HH:mm

#Verify entry date. Get timestamps
echo -n "Is this entry for today?: "
read yn

if [ ${yn:0:1} == "y" ] || [ ${yn:0:1} == "Y" ]
  then
    today=`date +%Y-%m-%d`
elif [ ${yn:0:1} == "n" ] || [ ${yn:0:1} == "N" ]
    then
      echo -n "What date are you entering hours for? (yyyy-mm-dd): "
      read today
#   Figure out data validation for yyyy-mm-dd format one of these days.
else
  echo "It was a simple question."
  exit
fi

now=`date +%Y-%m-%d:%H:%M:%S`

#Add notes
echo -n "What did you work on?: "
read notes

#Calculate hours
if [ $endmin -lt $stmin ] && [ $sthr -lt $endhr ]
  then
    let hours=$endhr-$sthr-1
    let mins=$stmin-$endmin
      case $mins in
        "15") mins=.75;;
        "30") mins=.50;;
        "45") mins=.25;;
        *) echo "Error: Please use 15 minute intervals."
        exit
      esac
else
  let hours=$endhr-$sthr
  let mins=$endmin-$stmin
    case $mins in
      "0") mins=.0;;
      "15") mins=.25;;
      "30") mins=.5;;
      "45") mins=.75;;
      *) echo "Error: Please use 15 minute intervals."
      exit
    esac
fi
echo "Total hours: " $hours$mins
echo $now

#Create file
echo "cehnstrom|$today|$staht|$today|$end|$hours$mins|MGHPCC/INTERN|Y|N|$notes" > ~/Hours/ehnstrom_hours_$now
#Mail info
echo -e "cehnstrom|$today|$staht|$today|$end|$hours$mins|MGHPCC/INTERN|Y|N|$notes" | mail -s "hours $today" -r cehnstrom@techsquare.com sb@intranet.techsquare.com cehnstrom@techsquare.com
