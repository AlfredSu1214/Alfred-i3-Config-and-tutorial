PERC="$(top -n 1 | head -n 3 | tail -n 1 | awk '{print $2 + $4}')"

if [ "$1" = "b" ]
then
	STAGE=$(( ($PERC + 5) / 12))
	case $STAGE in
		0 )
			echo " " && exit 0
		;;
		1 )
			echo "▁" && exit 0
		;;
		2 )
			echo "▂" && exit 0
		;;
		3 )
			echo "▃" && exit 0
		;;
		4 )
			echo "▄" && exit 0
		;;
		5 )
			echo "▅" && exit 0
		;;
		6 )
			echo "▆" && exit 0
		;;
		7 )
			echo "▇" && exit 0
		;;
		* )
			echo "█" && exit 0
		;;
	esac
else
	echo " $PERC%"
fi
