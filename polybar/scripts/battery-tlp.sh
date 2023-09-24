#!/bin/sh

battery=$(printf "%.0f" $(sudo tlp-stat -b | tac | grep -m 1 "Charge" |  tr -d -c "[:digit:],."))

case $(( ( $battery + 10 ) / 25 )) in
	4 )
		echo "  $battery%"
	;;
	3 )
		echo "  $battery%"
	;;
	2 )
		echo "  $battery%"
	;;
	1 )
		echo "  $battery%"
	;;
	* )
		echo "  $battery%"
	;;
esac
