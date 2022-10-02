#!/bin/sh

on_msg="on"
off_msg="off"

# Check if btusb is loaded
if ! lsmod | grep btusb 2>&1 /dev/null; then
  echo $off_msg
  exit 0
fi

# Check if bluetooth device is blocked
blocked=$(rfkill list \
            | grep -A 2 "Bluetooth" \
            | awk '{ if ($3 == "yes") {print $3}}')
if [ -n "$blocked" ] ; then
  echo $off_msg
  exit 0
fi

# Check if bluetooth service is active
systemd_status=$(systemctl is-active bluetooth.service)
if [ ! "$systemd_status" = "active" ]; then
  echo $off_msg
  exit 0
fi

# Bluetooth is on
echo $on_msg
