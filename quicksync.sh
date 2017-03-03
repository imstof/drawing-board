#!/bin/bash
#Just update doc files

#Down
rsync -uzhave ssh --exclude 'pythonfun' --progress cehnstrom@aquinas.techsquare.com:~/Documents/ ~/Documents/

#Up
rsync -uzhave ssh --exclude '*.swp' --exclude 'pythonfun' --progress ~/Documents/ cehnstrom@aquinas.techsquare.com:~/Documents/
