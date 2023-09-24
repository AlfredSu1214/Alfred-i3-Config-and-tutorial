PER=$(free | awk 'NR==2{printf("%d", $3*100/$2)}')



if [ "$1" = "b" ]
then
	STAGE=$(( (${PER%.*} + 5) / 12))
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
	echo " $PER"
fi
