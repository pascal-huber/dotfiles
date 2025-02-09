#!/bin/bash

hwmon_dir="$(echo /sys/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.0/hwmon/*)"
temp_file="${hwmon_dir}/temp1_input"
rpm_file="${hwmon_dir}/fan1_input"

temp=$(cat "$temp_file" | awk '{print int($0/1000 + 0.5)}')
rpm=$(cat "$rpm_file" | awk '{printf "%.1f", $0/1000}')

echo "${temp}°C ${rpm}krpm"
