#!/bin/bash

HISTFILE=~/.bash_history
set -o history
history | awk -F " " '{$1=""; print $0}' | sort -u
