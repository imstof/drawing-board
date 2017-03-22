#!/bin/bash

# back up then sync profile folders (and not break anything)

#kill tbird
pidkill thunderbird
#back up .msf extentions on both hosts
	if rsync -hav /home/imstof/.thunderbird/3jg4e0zn.default/*.msf /home/imstof/.thunderbird/3jg4e0zn.default.olde/ && rsync -uzhave ssh 192.168.13.30:/home/imstof/.thunderbird/mv2ohpvu.default/.msf 192.168.13.30:/home/imstof/.thunderbird/mv2ohpvu.default.olde/
	then
#	#sync .msf up, then down
		if rsync -uzhave ssh /home/imstof/.thunderbird/3jg4e0zn.default/*.msf 192.168.13.30:/home/imstof/.thunderbird/mv2ohpvu.default/
		then
			rsync -uzhave ssh 192.168.13.30:/home/imstof/.thunderbird/mv2ohpvu.default//home/imstof/.thunderbird/3jg4e0zn.default/
		fi
	fi
#start tbird
thunderbird
