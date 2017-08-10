#!/bin/bash

#code snippet

NOW=$(date --date="$1" +"%Y-%m-%d")

START=$(echo $(
	z=23.75
        for x in $(cat ~/Documents/$NOW-cehnstrom | cut -d'|' -f2 | cut -d' ' -f2 | sed s/:15/.25/g| sed s/:30/.50/g | sed s/:45/.75/g | sed s/:00/.00/g)
        do
                for y in $(cat ~/Documents/$NOW-cehnstrom | cut -d'|' -f2 | cut -d' ' -f2 | sed s/:15/.25/g| sed s/:30/.50/g | sed s/:45/.75/g | sed s/:00/.00/g)                           
                do
                        if [[ $(echo $x"<"$y | bc) == 1 && $(echo $x"<"$z | bc) == 1 ]]
                        then
                                z=$x
                        fi
                done
        done
echo $z
))
echo "START= "$START             #TEST

END=$(echo $(
        z=00.00
        for x in $(cat ~/Documents/$NOW-cehnstrom | cut -d'|' -f3 | cut -d' ' -f2 | sed s/:15/.25/g| sed s/:30/.50/g | sed s/:45/.75/g | sed s/:00/.00/g)
        do                                                                                    
                for y in $(cat ~/Documents/$NOW-cehnstrom | cut -d'|' -f3 | cut -d' ' -f2 | sed s/:15/.25/g| sed s/:30/.50/g | sed s/:45/.75/g | sed s/:00/.00/g)
                do
                        if [[ $(echo $x">"$y | bc) == 1 && $(echo $x">"$z | bc) == 1 ]]
                        then
                                z=$x
                        fi
                done
        done
        echo $z
))
echo $END       #TEST

