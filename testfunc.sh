#!/bin/bash

# test functions

        while true
        do
                read -p "Enter start date as YYYY-MM-DD (default is 1st of month): " sdate
                if [ -z "$sdate" ]
                then
                        sdate=$(date +"%Y-%m-01")
                fi  
#       echo $sdate  #test
                sdcheck=$(echo $sdate | tr -d '-')
		mocheck=$(echo $sdate | cut -d'-' -f2)
		if [[ ${mocheck:0:1} -eq 0 ]]
		then
			mocheck=${mocheck:1:1}
		fi
		echo $mocheck   #test
		dycheck=$(echo $sdate | cut -d'-' -f3)
		if [[ ${dycheck:0:1} -eq 0 ]]
		then
			dycheck=${dycheck:1:1}
		fi
                if [[ ${sdate:4:1} == "-" && ${sdate:7:1} == "-" && ($sdcheck -eq $sdcheck) && $(echo $sdate | cut -d'-' -f1) -le $(date +"%Y") && $mocheck -gt 0 && $mocheck -lt 13 && $dycheck -gt 0 && $dycheck -lt 32 ]] 2>/dev/null
                then
                        break
                fi  
        echo "Please enter a valid date."
        done

