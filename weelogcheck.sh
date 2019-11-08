#!/bin/bash

#takes one arg = date|glob

while getopts :hd:g: opt
do
	case $opt in
		d)
			wdate=$(date -d "$OPTARG" +%y-%m-%d 2>/dev/null)
			if [[ -z $wdate ]]
			then
				echo "invalid date \"$OPTARG\"" 1>&2
				exit 1
			fi
			;;
		g)
			wglob=$OPTARG
			;;
		\?)
			echo "invalid option \"-$OPTARG\""
			exit 1
			;;
	esac
done

if [[ -z $wdate ]] && [[ -z $wglob ]]
then
	echo "need some args, dude"
	exit 1
fi

if [[ -n $wdate ]] && [[ -n $wglob ]]
then
	echo "only one arg, please"
	exit 1
fi

[[ -n $wdate ]] && grep $wdate /home/imstof/.weechat/logs/python.t3chsquar3.slack.com.* | grep -ve general -ve m.wee | cut -d ':' -f2-

[[ -n $wglob ]] && grep $wglob /home/imstof/.weechat/logs/python.t3chsquar3.slack.com.* | grep -ve general -ve m.wee | cut -d ':' -f2-
