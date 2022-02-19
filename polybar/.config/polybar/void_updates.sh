#!/bin/bash

packages=$(xbps-install -nuM 2>/dev/null)

# exit code 19 for conflict
if [ "0" != "$?" ]; then
  echo "err"
  exit
fi

to_install=$(echo "$packages" |
               sed '/^$/d' |
               awk '{print $2}' |
               grep -c -v "hold")

power_symbol=""

# packages on hold
if (( $(xbps-query -H | wc -l) > 0 )); then
  power_symbol="${power_symbol}h"
fi

# orphans
if (( $(xbps-query -O | wc -l) > 0 )); then
  power_symbol="${power_symbol}o"
fi

# manually installed
# TODO: fix update-check for manually installed packages
#       it currently only works when connected to the internet
# cd ~/git/void-packages
# for pkg in $(xpkg -D); do
#     if (( $(./xbps-src update-check "$pkg" | wc -l) > 0 )); then
#       power_symbol="${power_symbol}+"
#       break
#     fi
# done

echo "${to_install}%{T8}${power_symbol}%{T-}"
