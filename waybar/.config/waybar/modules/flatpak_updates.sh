#!/usr/bin/env bash
#
fp_updates=$(flatpak remote-ls --updates 2>/dev/null)

if [ "0" != "$?" ]; then
  echo "?"
  exit
fi

ctr=$(echo "$fp_updates" | grep -v "^Name" | grep -v -e "^$" | wc -l)
echo "${ctr}"
