#!/bin/bash

ps aux | awk -F " " "/$1/ {print\$2;}" | xargs kill -9 2>/dev/null
