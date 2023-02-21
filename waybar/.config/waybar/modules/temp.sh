#!/bin/bash

sensor="/sys/class/thermal/thermal_zone5/temp"
temps=(
  [55]="cool"
  [70]="mkay"
  [80]="phuu"
)
high_temp_msg="stopit"

temp=$(<"$sensor" sed 's/...$//')

for threshold in "${!temps[@]}"; do
  if [ "$temp" -le "$threshold" ]; then
    echo "${temps[$threshold]}"
    exit 0
  fi
done

echo "$high_temp_msg"
