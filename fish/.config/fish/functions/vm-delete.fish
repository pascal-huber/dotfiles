#!/usr/bin/env fish

function vm-delete --description 'Delete a dev vm and its disk image'
    if test (count $argv) -eq 0
        echo "Usage: vm-delete <name>" >&2
        return 1
    end
    set -l name $argv[1]
    set -l disk ~/vms/$name.qcow2

    if not test -e $disk
        echo "No such disk: $disk" >&2
        return 1
    end

    set -l disk_real (readlink -f $disk)

    # Refuse if this is (or resolves to) the current template target
    set -l template_link ~/vms/template
    if test -e $template_link
        set -l template_real (readlink -f $template_link)
        if test "$disk_real" = "$template_real"
            echo "Refusing to delete: '$name' is the current template ($template_link)." >&2
            return 1
        end
    end

    # Refuse if any other vm's disk uses this one as a backing file
    for other in ~/vms/*.qcow2
        set -l other_real (readlink -f $other)
        if test "$other_real" = "$disk_real"
            continue
        end
        set -l backing (qemu-img info --output=json $other 2>/dev/null | string match -r '"backing-filename":\s*"([^"]+)"' -g)
        if test -n "$backing"
            set -l backing_real (readlink -f $backing)
            if test "$backing_real" = "$disk_real"
                echo "Refusing to delete: '$name' is used as the base image for '"(basename $other .qcow2)"'." >&2
                return 1
            end
        end
    end

    read -l -P "Delete VM '$name' and its disk $disk? [y/N] " confirm
    if not string match -qr '^[Yy]' -- $confirm
        echo "Aborted."
        return 1
    end

    if virsh --connect qemu:///system dominfo $name >/dev/null 2>&1
        virsh --connect qemu:///system destroy $name >/dev/null 2>&1
        sudo virsh --connect qemu:///system undefine $name
        or return
    end

    rm $disk
    and echo "Deleted $name."
end
