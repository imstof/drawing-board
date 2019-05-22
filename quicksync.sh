#!/bin/bash
#Just update doc files
#and slack logs

#Up
rsync -uzhave ssh --exclude-from='/home/imstof/exclude-from-sync.txt' --progress ~/Documents/ cehnstrom@aquinas.techsquare.com:~/Documents/
#only run this UP from desktop
#rsync -uzhave ssh --progress ~/.weechat/logs/ cehnstrom@aquinas.techsquare.com:~/Documents/.slacklogs/

#Down
rsync -uzhave ssh --exclude '.swp' --progress cehnstrom@aquinas.techsquare.com:~/Documents/ ~/Documents/
#only run this DOWN from lap distros
#rsync -uzhave ssh --progress cehnstrom@aquinas.techsquare.com:~/Documents/.slacklogs/ ~/Documents/.slacklogs/
