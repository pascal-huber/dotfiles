#!/usr/bin/env fish

complete -c vm-open -f \
    -n '__fish_is_first_arg' \
    -a '(virsh --connect qemu:///session list --all --name 2>/dev/null | string match -rv "^\$")' \
    -d 'VM'

