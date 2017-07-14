#!/bin/bash

#script to delete file from Desktop, Laptop, and Aquinas
#from Desktop

echo "deleting local..."
if rm $1
then
	echo "...deleted"
else
	echo "...failed"
fi
echo "deleting from aquinas..."
if ssh cehnstrom@aquinas.techsquare.com rm $(echo $1 | sed 's/imstof/cehnstrom/')
then
	echo "...deleted"
else
	echo "...failed"
fi

# check if desktop is connected. if not, add script to crontab to keep trying
echo "deleting from Desktop-MGHPCC..."
if [[ -n $(ping -c1 192.168.13.30 | grep ' 0% packet loss') ]]
then
	if ssh 192.168.13.30 rm $1
	then
		echo "...deleted"
	fi
else
	echo "...failed"
	echo "adding job to crontab..."
	if [[ -z $(crontab -l) ]]
	then
		if echo "1 7-18 * * 1-5 /home/imstof/bin/rmdeskcron $1" | crontab -
		then
			echo "...file will be deleted when Desktop-MGHPCC is present"
		else
			echo "...failed"
		fi
	else
		if crontab -l | sed "$ a\*1 7-18 * * 1-5 \/home\/imstof\/bin\/rmdeskcron $1" | crontab -
		then
			echo "...file will be deleted when Desktop-MGHPCC is present"
		else
			echo "...failed"
		fi
	fi
fi
