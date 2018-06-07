#!/bin/bash
#Just update doc files

#Down
rsync -uzhave ssh --exclude '.swp' --progress cehnstrom@aquinas.techsquare.com:~/Documents/ ~/Documents/

#Up
rsync -uzhave ssh --exclude-from='/home/imstof/exclude-from-sync.txt' --progress ~/Documents/ cehnstrom@aquinas.techsquare.com:~/Documents/
