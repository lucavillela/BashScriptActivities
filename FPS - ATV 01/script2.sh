#!/bin/bash

result=0

if [ $# -gt 0 ]
then
	if [ -d "$1" ]
	then
		result=1
		
	elif [ -x "$1" ]
	then
		result=2
	fi
fi

echo $result 



