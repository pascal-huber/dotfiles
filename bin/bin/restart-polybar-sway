#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Detect screens to start polybar on
# PRIMARY=$(xrandr --listmonitors | grep '*' | awk {'print $4'})
# NONPRIMARY=$(xrandr | grep " connected" | grep -v "primary"| awk '{ print$1 }')

# echo "primary: $PRIMARY"
# echo "secondary: $SECONDARSECONDARYY"

if [ -z $NONPRIMARY ] ; then
  MONITOR=$PRIMARY polybar --reload primary &
else
  MONITOR=$PRIMARY polybar --reload primary &
  for m in $NONPRIMARY; do
    MONITOR=$m polybar --reload secondary &
  done
fi
