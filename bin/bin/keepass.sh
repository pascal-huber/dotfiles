#!/bin/bash
#
# This requires the following settings in KeePassXC
#  - minimize instead of app exit
#  - show a system tray icon
# TODO: check if the keepass settings are actually required

if [ $(ps h -C keepassxc | wc -l) != 0 ]; then
    visible=$(xdotool search --all --onlyvisible --class keepassxc | wc -l)
    all=$(xdotool search --all --class keepassxc | wc -l)
    if [ $all = $visible ]; then
        # hide window
        i3-msg "[class=KeePassXC] move scratchpad"
    else
        # open/show window
        keepassxc; i3-msg "[class=KeePassXC] scratchpad show"
    fi
else
    # start keepassxc
    keepassxc &
fi
