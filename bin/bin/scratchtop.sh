#!/usr/bin/env bash

all=$(xdotool search --all --classname scratchtop | wc -l)

if [ $all != 0 ]; then
    i3-msg "[instance=scratchtop] kill"
else
    urxvt -name scratchtop +sb -e htop &
fi
