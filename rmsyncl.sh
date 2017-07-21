#!/bin/bash

#script to delete file from Desktop, Laptop, and Aquinas
#from Desktop

#new version to expand dir/*
for file in $@
do
	if [[ -d $file ]]
	then
		echo $file
		echo
		echo "deleting local directory..."
		if rm -r $file
		then
			echo "...deleted"
		else
			echo "...failed"
		fi
		echo "deleting directory from aquinas..."
		if ssh cehnstrom@aquinas.techsquare.com rm -r $(echo $file | sed 's/imstof/cehnstrom/')
		then
			echo "...deleted"
		else
			echo "...failed"
		fi
		# check if desktop is connected. if not, add script to crontab to keep trying
		echo "deleting directory from Desktop-MGHPCC..."
		if [[ -n $(ping -c1 192.168.13.30 | grep ' 0% packet loss') ]]
		then
			if ssh 192.168.13.30 rm -r $file
			then
				echo "...deleted"
			fi
		else
			echo "...failed"
			echo "adding job to crontab..."
	#sed won't '$ a' to empty crontab, echo the single line
			if [[ -z $(crontab -l) ]]
			then
				if echo "*/1 7-18 * * 1-5 /home/imstof/bin/rmdeskdircron $file" | crontab -
				then
					echo "...file will be deleted when Desktop-MGHPCC is present"
				else
					echo "...failed"
				fi
			else
				if crontab -l | sed "$ a\*\/1 7-18 * * 1-5 \/home\/imstof\/bin\/rmdeskcron $file" | crontab -
				then
					echo "...file will be deleted when Desktop-MGHPCC is present"
				else
					echo "...failed"
				fi
			fi
		fi

################################################ dir ^^^
	else
		echo $file
		echo
		echo "deleting local file..."
		if rm $file
		then
			echo "...deleted"
		else
			echo "...failed"
		fi
		echo "deleting file from aquinas..."
		if ssh cehnstrom@aquinas.techsquare.com rm $(echo $file | sed 's/imstof/cehnstrom/')
		then
			echo "...deleted"
		else
			echo "...failed"
		fi

		# check if desktop is connected. if not, add script to crontab to keep trying
		echo "deleting file from Desktop-MGHPCC..."
		if [[ -n $(ping -c1 192.168.13.30 | grep ' 0% packet loss') ]]
		then
			if ssh 192.168.13.30 rm $file
			then
				echo "...deleted"
			fi
		else
			echo "...failed"
			echo "adding job to crontab..."
	#sed won't '$ a' to empty crontab, echo the single line
			if [[ -z $(crontab -l) ]]
			then
				if echo "*/1 7-18 * * 1-5 /home/imstof/bin/rmdeskcron $file" | crontab -
				then
					echo "...file will be deleted when Desktop-MGHPCC is present"
				else
					echo "...failed"
				fi
			else
				if crontab -l | sed "$ a\*\/1 7-18 * * 1-5 \/home\/imstof\/bin\/rmdeskcron $file" | crontab -
				then
					echo "...file will be deleted when Desktop-MGHPCC is present"
				else
					echo "...failed"
				fi
			fi
		fi
	echo
	fi
done
