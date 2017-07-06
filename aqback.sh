#!/bin/bash
#Script to back up home dir to aquinas

rsync -uzhave ssh --progress --exclude-from='/home/imstof/exclude_from_backup.txt' /home/imstof cehnstrom@aquinas.techsquare.com:~/[BACKUP-FOLDER]
