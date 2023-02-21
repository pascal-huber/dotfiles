#!/bin/bash

arch=$(checkupdates 2> /dev/null)
if [ $? -ne 0 ]; then
  echo "?"
  exit 1
fi
aur=$(cower -u | wc -l)
n=$(echo "${arch}" | wc -l)
echo "${n} • ${aur}"
