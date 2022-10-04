#!/bin/bash

# sway
# swaymsg output eDP-1 enable
# swaymsg output DP-1 disable

# use the laptop screen only
$(xrandr --output eDP1 --primary --auto --output HDMI1 --off --output HDMI2 --off --output DP1 --off --output DP1 --off --output DP2 --off) &

# restart i3 with new dpi settings
i3-msg reload

# modify laptop keyboard layout to whitefox-ish config
xmodmap ~/.Xmodmap-laptop

# i3-msg refresh
