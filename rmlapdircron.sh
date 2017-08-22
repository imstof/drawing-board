#!/bin/bash

# used by 'rmsyncl' to rm file from KLaptop-TS when it becomes available then delete it's crontab on success

if [[ -n $(ping -c1 192.168.13.151 | grep ' 0% packet loss') ]]
then
	if ssh -i /home/imstof/.ssh/id_rsa_lapdesk 192.168.13.151 rm -r $1
	then
		echo $1 "deleted from KLaptop-TS" | mail -s "$1 deleted" cehnstrom@techsquare.com
		file=$(echo $1 | sed 's:\/:\\\/:g')
		crontab -l | sed "/rmlapdircron\ $file/d" | crontab -
	fi
fi
