#!/bin/bash

find /home/imstof/Documents/personal/gnucash_books -maxdepth 1 -type f -name 'Ehnstrom_Ledger.gnucash.*.*g*' | xargs tar -cvzf /home/imstof/Documents/personal/gnucash_books/archive/ledgers-$(date +%Y%m%d-%H%M).tgz 2>/dev/null

find /home/imstof/Documents/personal/gnucash_books -maxdepth 1 -type f -name 'Ehnstrom_Ledger.gnucash.*.*g*' -exec rm {} \;
