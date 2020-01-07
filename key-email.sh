#!/bin/bash

for user in $@
do
	echo -e "\n\nHello $user,\n\nThere are no passwords on the cluster, where all authentication is via ssh key. If you've forgotten the passphrase to your key you can generate a new pair with\n\nssh-keygen -t rsa\n\nand send us the contents of the public portion. We'll put that in place and you will be able to log in again.\n\nCheers,\nChristophe\n"
done
