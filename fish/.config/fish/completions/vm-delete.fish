#!/usr/bin/env

complete -c vm-delete -f
complete -c vm-delete -n __fish_is_first_arg \
    -a '(for f in ~/vms/*.qcow2; basename $f .qcow2; end | string match -v template)' \
    -d 'Existing VM'
