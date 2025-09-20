#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/forest"
all_monitors() { xrandr --query | grep " connected" | cut -d' ' -f1; }

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar
#polybar -q main -c "$DIR"/config.ini &
for m in $(all_monitors); do
  MONITOR="$m" polybar -q main -c "$DIR/forest/config.ini" &
done
