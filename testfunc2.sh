#!/bin/bash

testfunc(){
	echo $1
	echo $($1)
}

VAR=0

testfunc VAR
