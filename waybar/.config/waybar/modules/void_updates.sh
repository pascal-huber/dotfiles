#!/bin/bash
#
#
# echo "{\"text\": \"P\"}"

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

# private templates
UPDATE_LOG_FILE="https://raw.githubusercontent.com/pascal-huber/void-packages/gh-pages/updates.txt"
tooltip=""
size="$(curl -I $UPDATE_LOG_FILE 2>/dev/null | grep "content-length" | cut -d":" -f2 | tr -dc '[:alnum:]')"
if [ "$?" != "0" ]; then
   power_symbol="${power_symbol}?"
elif [ "$size" != "0" ]; then
   tooltip="$(curl $UPDATE_LOG_FILE 2>/dev/null)"
   power_symbol="${power_symbol}T"
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

text="${to_install}<span font_scale='superscript' rise='4000'>${power_symbol}</span>"
echo "{\"text\": \"$text\", \"tooltip\": \"${tooltip//$'\n'/\\n}\"}"
exit 0
