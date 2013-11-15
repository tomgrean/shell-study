#!/bin/sh

tom="${*:-`logname`}"

for elem in $tom; do
	echo "==========processes of user $elem========="
	ps -fu $elem
done

