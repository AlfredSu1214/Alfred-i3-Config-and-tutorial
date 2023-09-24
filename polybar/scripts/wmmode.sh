STAT=$(i3-msg -t get_binding_state | sed 's/{/ /g;s/}/ /g;s/"/ /g' | awk '{print $3}')
case $STAT in
	"default" )
		echo " $STAT"
		;;
	"apps" )
		echo "%{O-5}%{B#F51818}%{F#FAFAFA}  $STAT %{B- F-}"
		;;
	"resize" )
		echo "%{O-5}%{B#F51818}%{F#FAFAFA} 󰆾 $STAT %{B- F-}"
		;;
esac

echo $STAT
