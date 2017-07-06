#!/bin/bash

#sync with laptop while at mghpcc

#Down
rsync -uzhave ssh --exclude-from='/home/imstof/exclude-from-sync.txt' --progress imstof@192.168.13.29:~/Documents/ ~/Documents/

#Up
rsync -uzhave ssh --exclude-from='/home/imstof/exclude-from-sync.txt' --progress ~/Documents/ imstof@192.168.13.29:~/Documents/
