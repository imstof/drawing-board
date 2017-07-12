#!/bin/bash

# used by 'rmsyncl' to rm file from Desktop-MGHPCC when it becomes available then delete it's crontab on success

if 
then
	if ssh 192.168.13.30 rm $1
	then
		echo $1 "deleted from Desktop-MGHPCC" | mail -s "$1 deleted" cehnstrom@techsquare.com
	crontab -l | sed /rmdeskcron\ $1/d | crontab -
	fi
fi
