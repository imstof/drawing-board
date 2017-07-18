#!/bin/bash

#quick check of contract hours

cat $1 | sed '/HOME/d' | sed '/LUNCH/d' | cut -d'|' -f4 | sed '/^$/d' | paste -sd+ | bc
