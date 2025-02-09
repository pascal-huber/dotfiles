#!/bin/sh

hwmon_dir="$(echo /sys/devices/pci0000:00/0000:00:18.3/hwmon/*)"
temp_file="${hwmon_dir}/temp1_input"
temp=$(cat "$temp_file" | awk '{print int($0/1000 + 0.5)}')

echo "${temp}°C"
