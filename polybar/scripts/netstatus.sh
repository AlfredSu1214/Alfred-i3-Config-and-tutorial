#!/bin/sh

CONNECTED=$(connmanctl state | grep 'State' | awk '{print $3}')

if [ $CONNECTED = "idle" ]
then
	echo " offline" && exit 0
fi

ETH=$(ip a s eth0 | grep 'inet')

if [ -n "$ETH" ]
then
	echo "󰈀 eth0" && exit 0
fi

SSID=$(iwgetid -r)
STRENTH=$(cat /proc/net/wireless | awk 'NR==3 {printf("%.0f\n",$3*10/7)}')
LEVEL=$(( ($STRENTH + 10) / 25 ))

if [ -n "$SSID" ]
then
	case $LEVEL in
	0 )
		echo "󰤯 $SSID"	
	;;
	1 )
		echo "󰤟 $SSID"	
	;;
	2 )
		echo "󰤢 $SSID"	
	;;
	3 )
		echo "󰤥 $SSID"	
	;;
	4 )
		echo "󰤨 $SSID"	
	;;
	esac
fi

