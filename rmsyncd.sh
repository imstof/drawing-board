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
		# check if laptop(s) are connected. if not, add script to crontab to keep trying
		echo "deleting directory from FLaptopK1..."
		if [[ -n $(ping -c1 192.168.13.29 | grep ' 0% packet loss') ]]
		then
			if ssh 192.168.13.29 rm -r $file
			then
				echo "...deleted"
			fi
		else
			echo "...failed"
			echo "adding job to crontab..."
	#sed won't '$ a' to empty crontab, echo the single line
			if [[ -z $(crontab -l) ]]
			then
				if echo "*/1 7-18 * * 1-5 /home/imstof/bin/rmFlapdircron $file" | crontab -
				then
					echo "...file will be deleted when FlaptopK1 is present"
				else
					echo "...failed"
				fi
			else
				if crontab -l | sed "$ a\*\/1 7-18 * * 1-5 \/home\/imstof\/bin\/rmFlapdircron $file" | crontab -
				then
					echo "...file will be deleted when FLaptopK1 is present"
				else
					echo "...failed"
				fi
			fi
		fi
		echo "deleting directory from Poptop1..."
		if [[ -n $(ping -c1 192.168.13.142 | grep ' 0% packet loss') ]]
		then
			if ssh 192.168.13.141 rm -r $file
			then
				echo "...deleted"
			fi
		else
			echo "...failed"
			echo "adding job to crontab..."
	#sed won't '$ a' to empty crontab, echo the single line
			if [[ -z $(crontab -l) ]]
			then
				if echo "*/1 7-18 * * 1-5 /home/imstof/bin/rmPopdircron $file" | crontab -
				then
					echo "...file will be deleted when Poptop1 is present"
				else
					echo "...failed"
				fi
			else
				if crontab -l | sed "$ a\*\/1 7-18 * * 1-5 \/home\/imstof\/bin\/rmPopdircron $file" | crontab -
				then
					echo "...file will be deleted when Poptop1 is present"
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

		# check if laptop(s) are connected. if not, add script to crontab to keep trying
		echo "deleting file from FlaptopK1..."
		if [[ -n $(ping -c1 192.168.13.29 | grep ' 0% packet loss') ]]
		then
			if ssh 192.168.13.29 rm $file
			then
				echo "...deleted"
			fi
		else
			echo "...failed"
			echo "adding job to crontab..."
	#sed won't '$ a' to empty crontab, echo the single line
			if [[ -z $(crontab -l) ]]
			then
				if echo "*/1 7-18 * * 1-5 /home/imstof/bin/rmFlapcron $file" | crontab -
				then
					echo "...file will be deleted when FlaptopK1 is present"
				else
					echo "...failed"
				fi
			else
				if crontab -l | sed "$ a\*\/1 7-18 * * 1-5 \/home\/imstof\/bin\/rmFlapcron $file" | crontab -
				then
					echo "...file will be deleted when FlaptopK1 is present"
				else
					echo "...failed"
				fi
			fi
		fi
		echo "deleting file from PoptopK1..."
		if [[ -n $(ping -c1 192.168.13.141 | grep ' 0% packet loss') ]]
		then
			if ssh 192.168.13.141 rm $file
			then
				echo "...deleted"
			fi
		else
			echo "...failed"
			echo "adding job to crontab..."
	#sed won't '$ a' to empty crontab, echo the single line
			if [[ -z $(crontab -l) ]]
			then
				if echo "*/1 7-18 * * 1-5 /home/imstof/bin/rmPopcron $file" | crontab -
				then
					echo "...file will be deleted when Poptop1 is present"
				else
					echo "...failed"
				fi
			else
				if crontab -l | sed "$ a\*\/1 7-18 * * 1-5 \/home\/imstof\/bin\/rmPopcron $file" | crontab -
				then
					echo "...file will be deleted when Poptop1 is present"
				else
					echo "...failed"
				fi
			fi
		fi

	echo
	fi
done
