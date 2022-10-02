#!/bin/bash

# Terminate already running bar instances and wait until done
pkill "^polybar$"
# while pgrep -x polybar >/dev/null; do sleep 1; done

# Detect screens to start polybar on
PRIMARY=$(xrandr --listmonitors | grep '*' | awk {'print $4'})
NONPRIMARY=$(xrandr | grep " connected" | awk '{ print$1 }' | grep -v "^${PRIMARY}$")

echo "primary: $PRIMARY"
echo "secondary: $NONPRIMARY"

if [ -z $NONPRIMARY ] ; then
  MONITOR=$PRIMARY polybar --reload primary &
else
  MONITOR=$PRIMARY polybar --reload primary &
  for m in $NONPRIMARY; do
    echo "nope" # MONITOR=$m polybar --reload secondary &
  done
fi

# MONITOR=HDMI2 polybar --reload primary


# monitors=$(polybar --list-monitors | cut -d":" -f1)
# # if only one monitor present: make it primary
# # if multiple are present, make DP1 primary (if present)
# # if mulitple are present but not eDP1, make first one primary
# if [ "$number_of_monitors" = "1" ]; then
#   MONITOR=$monitors polybar --reload primary &
# elif [ "
# fi
