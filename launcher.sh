#!/usr/bin/env sh

POLYBAR_CACHE="$HOME/.cache/polybar"
POLYBAR_SWITCH="$POLYBAR_CACHE/justdoit"

function terminate_polybar() {

	# Terminate already running bar instances
	killall -q polybar
	
	# Wait until the processes have been shut down
	while pgrep -x polybar >/dev/null; do sleep 1; done
	
	rm $POLYBAR_SWITCH
}

function start_polybar() {

	# Launch bar1 and bar2
	polybar top &
	touch $POLYBAR_SWITCH
}
[ -d $POLYBAR_CACHE ] || mkdir -p $POLYBAR_CACHE
case $1 in
	toggle)
		if pgrep -x polybar >/dev/null; then
			terminate_polybar
		else
			start_polybar
		fi;;
	default)
		if [ -f $POLYBAR_SWITCH ]; then
			terminate_polybar
			start_polybar
		else
			terminate_polybar
		fi;;
	*)
		terminate_polybar
		start_polybar;;
esac
