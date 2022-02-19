#!/usr/bin/env bash

x=$(cpupower frequency-info -p | grep "current")
x=${x##*and\ }
x=${x%\.*}

echo "$x"
