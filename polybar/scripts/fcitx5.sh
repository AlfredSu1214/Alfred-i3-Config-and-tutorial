#!/bin/bash

PROCESS=$(fcitx5-remote)

if [ $PROCESS = "0" ]
then
	echo "none" && exit 0
fi

LAYOUT=$(setxkbmap -print | awk -F"+" '/xkb_symbols/ {print $2}')

case $LAYOUT in
"us(dvorak)" )
	LAYOUT="dv"
	;;
* )
	;;
esac

IM=$(fcitx5-remote -n)

case $IM in
"keyboard-us-dvorak" )
	IM="us"
	;;
"keyboard-us" )
	IM="us"
	;;
"pinyin" )
	IM="pin"
	;;
esac

echo "$LAYOUT $IM"
