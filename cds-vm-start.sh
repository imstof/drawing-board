#!/bin/bash

sudo virsh start CentOS-7dot6-VM
echo waiting to connect...
sleep 12
echo trying to connect...
until sudo ssh -lroot -i /root/.ssh/id_rsa_lapdesk 192.168.122.76
do
	sleep 1
done
sudo virsh shutdown CentOS-7dot6-VM
