#!/bin/bash

if [ $# -gt 0 ]
then
	if [ -d "$1" ]
	then
		echo 1
		
	elif [ -x "$1" ]
	then
		echo 2
	else
		echo 0
	fi
fi





