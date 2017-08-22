#!/bin/bash

#script to delete file from Desktop, Laptop, and Aquinas
#from Desktop

echo "deleting from aquinas..."
ssh cehnstrom@aquinas.techsquare.com rm $(echo $1 | sed 's/imstof/cehnstrom/')
echo "deleting from KLaptop..."
ssh 192.168.13.151 rm $1
echo "deleting local..."
rm $1
