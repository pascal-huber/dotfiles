#!/bin/bash

sensor="/sys/class/thermal/thermal_zone5/temp"
temps=(
  [55]="cool"
  [70]="mkay"
  [80]="phuu"
)
display="bruh"

temp=$(<"$sensor" sed 's/...$//')

for threshold in "${!temps[@]}"; do
  if [ "$temp" -le "$threshold" ]; then
    display="${temps[$threshold]}"
    break
  fi
done

echo "$display"
