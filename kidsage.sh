#!/bin/bash


jyear=$(if [[ $(date +"%m%d") - 
#bsecs=$(date --date="06/24/2012 20:31" +"%s")
bsecs=$(date --date="06/24/$jyear 20:31" +"%s")
nsecs=$(date +"%s")

jsecs=($nsecs - $bsecs)

echo $bsecs		#test
