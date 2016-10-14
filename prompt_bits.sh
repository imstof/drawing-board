#!/bin/bash

#snippet from addhours for prompting

if
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

	read -p "This week's cluster hours?: " yn
	if [ ${yn:0:1} == "y" ] || [ ${yn:0:1} == "Y" ]
	then
	fi
