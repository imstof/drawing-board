#!/bin/bash

gethours(){
	echo $([ -n "$(grep $1 $2 | awk -F'|' '$4 {printf $4"+"}' | sed 's/+$//' | paste | bc)" ] && grep $1 $2 | awk -F'|' '$4 {printf $4"+"}' | sed 's/+$//' | paste | bc || echo 0)
}

#file0=/home/imstof/Documents/2019-03-12-cehnstrom
#file1=/home/imstof/Documents/Hours-2019/03/2019-03-12-cehnstrom

#[[ ! -e $file0 ]] && echo yay || echo $file1

sdate=20190312
edate=20190313
codes="TS C3 ENG"

for code in $codes
do
tmphours=0

for tmpdate in $(seq $sdate $edate)
do
	file0=/home/imstof/Documents/$(date -d $tmpdate +%Y-%m-%d)-cehnstrom
	file1=/home/imstof/Documents/Hours-$(date -d $tmpdate +%Y)/$(date -d $tmpdate +%m)/$(date -d $tmpdate +%Y-%m-%d)-cehnstrom
	tmphours=$(echo $tmphours+$(
	[[ -e $file0 ]] && gethours $code $file0 || gethours $code $file1) | bc)
done

echo $code $tmphours
done
