#!/bin/bash

# back up then sync profile folders (and not break anything)

#kill tbird (no cli way to do this gracefully?)
read -p "Have you gracefully shutdown TBird? " yn
if [ $yn == "y" ]
then
	#back up .msf extentions on both hosts
	if rsync -hav --include="*/" --include="prefs.js" --include="*.msf" --exclude="*" --progress /home/imstof/.thunderbird/3jg4e0zn.default/ /home/imstof/.thunderbird/3jg4e0zn.default.olde/ && rsync -e ssh -uzhav --include="*/" --include="*.msf" --exclude="*" --progress 192.168.13.30:/home/imstof/.thunderbird/mv2ohpvu.default/ /home/imstof/.thunderbird/lap.mv2ohpvu.default.olde/
	then
	echo "$(tput setaf 2)step 1$(tput sgr 0)"		#test
	#	#sync .msf up, then down
		if rsync -e ssh -uzhav --include="*/" --include="prefs.js" --include="*.msf" --exclude="*" --progress /home/imstof/.thunderbird/3jg4e0zn.default/ 192.168.13.30:/home/imstof/.thunderbird/mv2ohpvu.default/
		then
	echo "$(tput setaf 2)step 2$(tput sgr 0)"		#test
		rsync -e ssh -uzhav --include="*/" --include="prefs.js" --include="*.msf" --exclude="*" --progress 192.168.13.30:/home/imstof/.thunderbird/mv2ohpvu.default/ /home/imstof/.thunderbird/3jg4e0zn.default/ 
		fi
	fi
	#start tbird
	thunderbird &
	exit 0
else
	echo "Please gracefully shutdown TBird and rerun."
	exit 1
fi
