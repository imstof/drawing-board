#!/bin/bash

#sync with desktop while at mghpcc

#Down
rsync -uzhave ssh --exclude-from='/home/imstof/exclude-from-sync.txt' --progress imstof@192.168.13.30:~/Documents/ ~/Documents/

#Up
rsync -uzhave ssh --exclude-from='/home/imstof/exclude-from-sync.txt' --progress ~/Documents/ imstof@192.168.13.30:~/Documents/
