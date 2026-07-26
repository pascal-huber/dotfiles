#!/usr/bin/env fish

complete -c vm-create -f
complete -c vm-create -l vcpus \
    -d 'Number of vCPUs (default: 14)' -x \
    -a '1 2 4 6 8 12 14 16'
complete -c vm-create -l memory \
    -d 'Memory in MB (default: 32000)' -x \
    -a '2048 4096 8192 16000 32000 65536'
