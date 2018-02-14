#!/bin/bash
#Just update doc files
#and slack logs

#Up
rsync -uzhave ssh --exclude-from='/home/imstof/exclude-from-sync.txt' --progress ~/Documents/ cehnstrom@aquinas.techsquare.com:~/Documents/
rsync -uzhave ssh --progress ~/.purple/logs/jabber/imstof@t3chsquar3.xmpp.slack.com/ cehnstrom@aquinas.techsquare.com:~/Documents/.slacklogs/

#Down
rsync -uzhave ssh --exclude '.swp' --progress cehnstrom@aquinas.techsquare.com:~/Documents/ ~/Documents/
#rsync -uzhave ssh --progress cehnstrom@aquinas.techsquare.com:~/Documents/.slacklogs/ ~/Documents/.slacklogs
