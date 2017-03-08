# open issuelist

vim ~/Documents/issuelist.txt

echo ""
read -p "Sync Documents folder? " yn

if [ $yn == "y" ]
then
	quicksync
fi
