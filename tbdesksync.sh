#!/bin/bash

# back up then sync profile folders (and not break anything)

if rsync -uhav /home/imstof/.thunderbird/mv2ohpvu.default/ /home/imstof/.thunderbird/mv2ohpvu.defaultdefault.olde && rsync -uzhave ssh 192.168.13.30:/home/imstof/.thunderbird/ADD-FOLDER-HERE 192.168.13.30:/home/imstof/.thunderbird/ADD-FOLDER-HERE.olde
then
	if rsync -uzhave ssh /home/imstof/.thunderbird/mv2ohpvu.default 192.168.13.30:/home/imstof/.thunderbird/ADD-FOLDER-HERE
	then
		rsync -uzhave ssh 192.168.13.30:/home/imstof/.thunderbird/mv2ohpvu.default/*.msf /home/imstof/.thunderbird/mv2ohpvu.default/*.msf
	fi
fi
