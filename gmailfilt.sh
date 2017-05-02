#!/bin/bash

# script to add gmail filters to xml file
# syntax: gmailfilt [target] [source]

# remove </feed> from target.xml
cat $1 | sed '/\/feed/d' > NewFilter.xml

# add new filters
cat $2 >> NewFilter.xml

# append </feed>
echo "</feed>" >> NewFilter.xml

