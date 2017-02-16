#!/bin/bash

m=08

while [[ $((10#$m)) -lt 13 ]]
do
	echo $m"!"
	printf -v m '%02d' $((10#$m+1))
done
