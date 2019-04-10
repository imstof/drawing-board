#!/bin/bash

virsh start CentOS-7dot6-VM
echo waiting 15 seconds for boot...
sleep 15
echo connecting...
ssh -lroot -i /root/.ssh/id_rsa_lapdesk 192.168.122.76
virsh shutdown CentOS-7dot6-VM
