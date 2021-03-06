#!/bin/bash
#Just update doc files on aquinas/aristotle
#and slack logs

#Up
#first clean up accounting ledger
ledger_saves
cd /home/imstof
rsync -uzhave ssh --exclude-from '/home/imstof/exclude-from-sync.txt' --progress Documents/ cehnstrom@aristotle.techsquare.com:~/Documents/
rsync -uzhave ssh --progress .weechat/logs/ cehnstrom@aristotle.techsquare.com:~/weechat-logs/
#only run this UP from desktop
#rsync -uzhave ssh --progress ~/.weechat/logs/ cehnstrom@aristotle.techsquare.com:~/Documents/.slacklogs/

#Down
rsync -uzhave ssh --exclude '.swp' --progress cehnstrom@aristotle.techsquare.com:~/Documents/ Documents/
#only run this DOWN from lap distros
#rsync -uzhave ssh --progress cehnstrom@aristotle.techsquare.com:~/Documents/.slacklogs/ ~/Documents/.slacklogs/
