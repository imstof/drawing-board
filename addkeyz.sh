#!/bin/bash

#add keys

echo id_rsa
ssh-add
echo eoferoot_id_dsa
ssh-add ~/.ssh/eoferoot_id_dsa
echo c3root_id_dsa
ssh-add ~/.ssh/c3root_id_dsa
