#!/bin/bash

virsh start CentOS-7dot6-VM
echo waiting to connect...
sleep 11
echo trying to connect...
until ssh -lroot -i /root/.ssh/id_rsa_lapdesk 192.168.122.76
do
	sleep 1
done
virsh shutdown CentOS-7dot6-VM
