#!/bin/bash
#Script to back up home dir to aquinas

#use -n for dry-run!!
rsync -nuzhave ssh --progress --exclude-from='/home/imstof/exclude_from_backup.txt' /home/imstof cehnstrom@aquinas.techsquare.com:~/[BACKUP-FOLDER] --delete

echo
echo "DRY-RUN complete."
read -p "Type $(tput setaf 2)yes$(tput sgr 0) to execute the rsync? " yn
if [[ $yn == "yes" ]]
then
	rsync -uzhave ssh --progress --exclude-from='/home/imstof/exclude_from_backup.txt' /home/imstof cehnstrom@aquinas.techsquare.com:~/[BACKUP-FOLDER] --delete
	echo "$(tput setaf 2)rsync executed$(tput sgr 0)"
	exit 0
else
	echo "$(tput setaf 1)rsync aborted!!$(tput sgr 0)"
	exit 0
fi
