#!/bin/bash

u=2
n=25

while [[ u -lt 10 ]]
do
	echo "{'dId':'node0"$n"', 'r':5,'p':'a','c':20,'lo': "$u",'hi': "$(($u+1))",'dT':'Exxact',  'dPp':'neuro','dPg':'' }," >> ./neuro_devices.py

	u=$((u+2))
	((n++))
done

while [[ u -lt 26 ]]
do
	echo "{'dId':'node0"$n"', 'r':5,'p':'a','c':20,'lo': "$u",'hi': "$(($u+1))",'dT':'Lenovo 3650 M5',  'dPp':'neuro','dPg':'' }," >> ./neuro_devices.py

	u=$((u+2))
	((n++))
done


echo "{'dId':'node055', 'r':5,'p':'a','c':20,'lo': 26,'hi': 29,'dT':'supermicro',  'dPp':'neuro','dPg':'' }," >> ./neuro_devices.py

echo "# R5-PA-C24" >> ./neuro_devices.py

u=1
n=001

while [[ u -lt 17 ]]
do
	echo "{'dId':'node"$n"', 'r':5,'p':'a','c':24,'lo': "$u",'hi': "$(($u+1))",'dT':'HP SL250s gen8',  'dPp':'neuro','dPg':'' }," >> ./neuro_devices.py
	printf -v n '%03d' $((10#$n+2))
	echo "{'dId':'node"$n"', 'r':5,'p':'a','c':24,'lo': "$u",'hi': "$(($u+1))",'dT':'HP SL250s gen8',  'dPp':'neuro','dPg':'' }," >> ./neuro_devices.py
	u=$((u+2))
	printf -v n '%03d' $((10#$n-1))
	echo "{'dId':'node"$n"', 'r':5,'p':'a','c':24,'lo': "$u",'hi': "$(($u+1))",'dT':'HP SL250s gen8',  'dPp':'neuro','dPg':'' }," >> ./neuro_devices.py
	printf -v n '%03d' $((10#$n+2))
	echo "{'dId':'node"$n"', 'r':5,'p':'a','c':24,'lo': "$u",'hi': "$(($u+1))",'dT':'HP SL250s gen8',  'dPp':'neuro','dPg':'' }," >> ./neuro_devices.py
	u=$((u+2))
	printf -v n '%03d' $((10#$n+1))
done

	echo "{'dId':'node017', 'r':5,'p':'a','c':24,'lo': 18,'hi': 19,'dT':'HP SL250s gen8',  'dPp':'neuro','dPg':'' }," >> ./neuro_devices.py
	echo "{'dId':'openmind', 'r':5,'p':'a','c':24,'lo': 20,'hi': 21,'dT':'HP SL250s gen8',  'dPp':'neuro','dPg':'' }," >> ./neuro_devices.py

u=22
n=018

while [[ u -lt 26 ]]
do
	echo "{'dId':'node"$n"', 'r':5,'p':'a','c':24,'lo': "$u",'hi': "$(($u+1))",'dT':'Exxact',  'dPp':'neuro','dPg':'' }," >> ./neuro_devices.py
	u=$((u+2))
	printf -v n '%03d' $((10#$n+1))

done

	echo "{'dId':'mlx-R5-PA-C24-U37', 'r':5,'p':'a','c':24,'lo': 37,'hi': 37,'dT':'Mellanox SX6025',  'dPp':'neuro','dPg':'' }," >> ./neuro_devices.py
	echo "{'dId':'mlx-R5-PA-C24-U39', 'r':5,'p':'a','c':24,'lo': 39,'hi': 39,'dT':'Mellanox SX6025',  'dPp':'neuro','dPg':'' }," >> ./neuro_devices.py

echo "# R5-PA-C23" >> ./neuro_devices.py

u=001
n=037

while [[ u -lt 19 ]]
do
	echo "{'dId':'node"$n"', 'r':5,'p':'a','c':23,'lo': "$u",'hi': "$(($u+1))",'dT':'Lenovo 3650 M5',  'dPp':'neuro','dPg':'' }," >> ./neuro_devices.py
	u=$((u+2))
	printf -v n '%03d' $((10#$n+1))
done

u=20
while [[ u -lt 38 ]]
do
	echo "{'dId':'node"$n"', 'r':5,'p':'a','c':23,'lo': "$u",'hi': "$(($u+1))",'dT':'Lenovo 3650 M5',  'dPp':'neuro','dPg':'' }," >> ./neuro_devices.py
	u=$((u+2))
	printf -v n '%03d' $((10#$n+1))
done

	echo "{'dId':'oms', 'r':5,'p':'a','c':23,'lo': 38,'hi': 39,'dT':'Lenovo 3650 M5',  'dPp':'neuro','dPg':'' }," >> ./neuro_devices.py
	echo "{'dId':'mlx-R5-PA-C23-U19', 'r':5,'p':'a','c':23,'lo': 19,'hi': 19,'dT':'Mellanox SX6025',  'dPp':'neuro','dPg':'' }," >> ./neuro_devices.py

echo "# R5-PC-C02" >> ./neuro_devices.py

u=1

while [[ u -lt 19 ]]
do
	echo "{'dId':'lustre-storage', 'r':5,'p':'b','c':2,'lo': "$u",'hi': "$(($u+3))",'dT':'Xyratex',  'dPp':'neuro','dPg':'' }," >> ./neuro_devices.py
	u=$((u+4))
done

u=21

while [[ u -lt 37 ]]
do
	echo "{'dId':'lustre-storage', 'r':5,'p':'b','c':2,'lo': "$u",'hi': "$(($u+3))",'dT':'Xyratex',  'dPp':'neuro','dPg':'' }," >> ./neuro_devices.py
	u=$((u+4))
done

	echo "{'dId':'bro-R5-PB-C02-U19', 'r':5,'p':'b','c':2,'lo': 19,'hi': 19,'dT':'brocade icx 6430-24',  'dPp':'neuro','dPg':'' }," >> ./neuro_devices.py
	echo "{'dId':'bro-R5-PB-C02-U20', 'r':5,'p':'b','c':2,'lo': 20,'hi': 20,'dT':'brocade icx 6430-24',  'dPp':'neuro','dPg':'' }," >> ./neuro_devices.py

	echo "{'dId':'mcgovern-ldap-mghpcc', 'r':5,'p':'b','c':2,'lo': 37,'hi': 37,'dT':'Dell R320',  'dPp':'neuro','dPg':'' }," >> ./neuro_devices.py
	echo "{'dId':'om-svc01', 'r':5,'p':'b','c':2,'lo': 38,'hi': 39,'dT':'Lenovo ',  'dPp':'neuro','dPg':'' }," >> ./neuro_devices.py
