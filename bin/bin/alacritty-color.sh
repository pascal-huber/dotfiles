#!/bin/bash

CONFIGFILE=${HOME}/.config/alacritty/alacritty.yml

colorline=$(cat ~/.config/alacritty/alacritty.yml \
              | grep -s "^colors\:\ \*")
active=$(echo ${colorline#colors\:\ \*})

if [ "$active" = "void" ]; then
  sed -i 's/\*void/\*solarized_light/g' ${CONFIGFILE}
else
  sed -i 's/\*solarized_light/\*void/g' ${CONFIGFILE}
fi
