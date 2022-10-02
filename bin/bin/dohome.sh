#!/bin/bash

# sway
# swaymsg output DP-1 enable scale 1
# swaymsg output eDP-1 disable

# use DP1 only
xrandr --output eDP1 --off --output HDMI2 --primary --auto --dpi 140
xrandr --output eDP1 --off --output DP1 --primary --auto --dpi 140

# restart i3 with new dpi settings
i3-msg restart

# setxkbmap -layout us -variant altgr-intl &

# modify laptop keyboard layout
xmodmap ~/.Xmodmap-whitefox

# restart-polybar
