#!/bin/bash
#Just update doc files on aquinas/aristotle
#and slack logs

#Up
#first clean up accounting ledger
ledger_saves
#rsync -uzhave ssh --exclude-from-from='/home/imstof/exclude-from-from-sync.txt' --progress ~/Documents/ cehnstrom@aquinas.techsquare.com:~/Documents/
rsync -uzhave ssh --exclude-from-from='/home/imstof/exclude-from-from-sync.txt' --progress ~/Documents/ cehnstrom@aristotle.techsquare.com:~/Documents/
rsync -uzhave ssh --progress ~/.weechat/logs/ cehnstrom@aristotle.techsquare.com:~/weechat-logs/
#only run this UP from desktop
#rsync -uzhave ssh --progress ~/.weechat/logs/ cehnstrom@aquinas.techsquare.com:~/Documents/.slacklogs/

#Down
#rsync -uzhave ssh --exclude-from '.swp' --progress cehnstrom@aquinas.techsquare.com:~/Documents/ ~/Documents/
rsync -uzhave ssh --exclude-from '.swp' --progress cehnstrom@aristotle.techsquare.com:~/Documents/ ~/Documents/
#only run this DOWN from lap distros
#rsync -uzhave ssh --progress cehnstrom@aquinas.techsquare.com:~/Documents/.slacklogs/ ~/Documents/.slacklogs/
