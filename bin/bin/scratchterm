#!/bin/bash

visible=$(xdotool search --all --onlyvisible --classname scratchterm | wc -l)
all=$(xdotool search --all --classname scratchterm | wc -l)

if [ $all != 0 ]; then
    if [ $all = $visible ]; then
        # hide window
        i3-msg "[instance=scratchterm] move scratchpad"
    else
        # open/show window
        i3-msg "[instance=scratchterm] scratchpad show"
    fi
else
    urxvt -name scratchterm +sb -depth 32 -bg rgba:3f00/3f00/3f00/dddd &
fi
