#!/bin/bash

#alarm chirp when locking screen
xflock4
sleep 0.6
aplay /home/imstof/Downloads/sounds/car_chirp_x.wav
