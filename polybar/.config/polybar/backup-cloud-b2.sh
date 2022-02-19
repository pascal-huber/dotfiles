#!/bin/bash

if backup_time=$(tail -n1 "${HOME}/.backup-cloud-times.log" 2>/dev/null); then
    time=$(date --utc +"%s")
    echo $(((time - backup_time) / 86400))
else
    echo "ERR"
fi
