#!/bin/bash

#quick calc of heloc interest

[[ -z $1 ]] && echo "Need a WSJ prime rate, dude." || WSJ=$1
[[ -z $2 ]] && echo "Need a principle amount, dude." || PRIN=$2

#INT=$(echo "\(\(\($1/365\)*30\)*$2\)" | bc -l)
INT=$(echo "((($1/365)*30)*$2)" | bc -l)
DEC=$(echo $(echo $INT | \grep -aob '\.' | grep -oE '[0-9]+')+3 | bc -l)

echo \$$2 at $1 would generate \$${INT:0:$DEC} monthly interest.
