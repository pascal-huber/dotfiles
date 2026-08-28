#!/usr/bin/env fish
function vm-open --description 'Open existing VM, starting it first if needed'
    set -l name $argv[1]

    if test -z "$name"
        echo "Usage: vm-open <vm-name>" >&2
        return 1
    end

    if not virsh --connect qemu:///session dominfo $name >/dev/null 2>&1
        echo "Error: VM '$name' does not exist" >&2
        return 1
    end

    set -l state (virsh --connect qemu:///session domstate $name)[1]
    set state (string trim -- $state)

    switch "$state"
        case running
            # already good to go
        case paused
            echo "Resuming VM '$name'..."
            if not virsh --connect qemu:///session resume $name
                echo "Error: failed to resume VM '$name'" >&2
                return 1
            end
        case '*'
            echo "Starting VM '$name'..."
            if not virsh --connect qemu:///session start $name
                echo "Error: failed to start VM '$name'" >&2
                return 1
            end
    end

    virt-manager --connect qemu:///session --show-domain-console $name &
    disown
end
