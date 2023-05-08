#!/bin/bash

set -e
[ -f "/proc/spl/kstat/zfs/arcstats" ]

awk '/^size/ { printf("%.1f GB\n", $3 / 1073741824) }' < /proc/spl/kstat/zfs/arcstats
