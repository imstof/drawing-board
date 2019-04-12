#!/bin/bash

echo "contact and shipping info:

Christophe Ehnstrom
413-552-4908
$1-admin@techsquare.com"

if [[ -n "$2" ]]
then echo "
Lawrence Gardner
413-552-4917
$1-admin@techsquare.com"
fi

echo "
MGHPCC/MIT
100 Bigelow St.
Holyoke, MA  01040"
