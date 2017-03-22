#!/bin/bash

# back up then sync profile folders (and not break anything)

if rsync -uhav /home/imstof/.thunderbird/3jg4e0zn.default /home/imstof/.thunderbird/3jg4e0zn.default.olde && rsynce -uzhave ssh 192.168.13.29:/home/imstof/.thunderbird/ADD-FOLDER-HERE 192.168.13.29:/home/imstof/.thunderbird/ADD-FOLDER-HERE.olde
then
	if rsync -uzhave ssh /home/imstof/.thunderbird/3jg4e0zn.default 192.168.13.29:/home/imstof/.thunderbird/ADD-FOLDER-HERE
	then
		rsynce -uzhave ssh 192.168.13.29:/home/imstof/.thunderbird/ADD-FOLDER-HERE /home/imstof/.thunderbird/3jg4e0zn.default
	fi
fi
