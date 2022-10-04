#!/bin/bash

DIRECTORY="${HOME}/cloud/eth/"

# old setup
# if [ $# -eq 0 ]; then
#   rofi-files list "${DIRECTORY}"
# else
#   rofi-files open "${DIRECTORY}/${1}"
# fi

if [ $# -eq 0 ]; then
  rofi-files list "${DIRECTORY}"
elif [[ "${1}" =~ \ \?$ ]]; then
  echo "${DIRECTORY}${1% ?}" > ~/.local/share/rofi/find-files
elif [ -f "${DIRECTORY}/${1}" ]; then
  rofi-files open "${DIRECTORY}/${1}"
else
  notify-send "something went wrong"
fi

# if [ $# -eq 0 ]; then
#   rofi-files list "${DIRECTORY}"
# elif [ "${1}" = "!! use arbitray binary" ]; then
#   echo "this is an arbitrary binary"
# elif [ -f "${DIRECTORY}/${1}" ]; then
#   rofi-files openwith "${DIRECTORY}/${1}"
# else
#   rofi-files run "$cmd"
# fi
