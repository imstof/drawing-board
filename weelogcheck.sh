#!/bin/bash

#takes one arg = date

grep $(date -d $1 +%y-%m-%d) /home/imstof/.weechat/logs/python.t3chsquar3.slack.com.* | grep -ve general -ve m.wee | cut -d ':' -f2-
