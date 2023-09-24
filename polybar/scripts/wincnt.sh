#!/bin/bash

CURWP=$(wmctrl -d | grep '*' | awk '{print($1)}')

IFS=$'\n'
str=$(echo "$(wmctrl -l | awk '{print($2)}')" | awk '{print $1}')
unset IFS

readarray -t arr <<< "$str"
WCNT=0

for (( n=0; n < ${#arr[*]}; n++))
do
	if [ ${arr[n]} = $CURWP ]
	then
		((WCNT=WCNT+1))
	fi
done
echo $WCNT
