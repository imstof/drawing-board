#!/bin/bash

for user in $@
do
	echo -e "\n\nHello $user,\n\nIf you've forgotten the passphrase for your key you can generate a new pair with\n\nssh-keygen -t rsa\n\nand send us the contents of the public portion. We'll put that in place and you'll be able to log in again.\n\nCheers,\nChristophe"
done
