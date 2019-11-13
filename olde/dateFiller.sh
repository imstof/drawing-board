#!/bin/bash
#test bits and scraps

m=1
d=1

#enter year of Hours-XXXX"
y=2014

while [[ $m -lt 13 ]]
do
if [[ -z ${m:1:1} ]]
then m=0$m
fi
while [[ $d -lt 31 ]]
do
if [[ -z ${d:1:1} ]]
then d=0$d
fi
echo "cehnstrom|"$y"-"$m"-"$d" 06:00|"$y"-"$m"-"$d" 17:00|1|TS|Y|N|stuff" > $m/$y-$m-$d-cehnstrom
if [[ ${d:0:1} == 0 ]]
then d=${d:1:1}
fi
((d++))
done
d=1
if [[ ${m:0:1} == 0 ]]
then m=${m:1:1}
fi
echo "m="$m				#test
((m++))
done

