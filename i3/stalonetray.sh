#!/bin/sh

if ! pgrep -x "stalonetray" > /dev/null
then
	stalonetray &
else
	killall stalonetray
fi
