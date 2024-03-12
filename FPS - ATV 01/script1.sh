#!/bin/bash

echo "Insert a file name and its type will be returned:"
read filename

if [ -e "$filename" ]
	then
		filepath=$(readlink -f "$filename")
		result=$(./script2.sh "$filepath")

		case $result in
			1)
				echo "this file is a directory";;
			2)
				echo "this file is an executable";;
			0)
				echo "this file is a normal file";;
			*)
				echo "error";;
		esac
else
	echo "this file does not exist"
fi

