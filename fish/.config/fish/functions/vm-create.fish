#!/usr/bin/env fish

function vm-create --description 'Create a new qemu dev vm'
    argparse 'vcpus=' 'memory=' -- $argv
    or return

    if test (count $argv) -eq 0
        echo "Usage: vm-create <name> [options]" >&2
        return 1
    end
    set -l name $argv[1]

    set -q _flag_vcpus; or set _flag_vcpus 14
    set -q _flag_memory; or set _flag_memory 32000

    set -l template_link ~/vms/template
    if not test -e $template_link
        echo "Template symlink not found: $template_link" >&2
        return 1
    end

    set -l template (readlink -f $template_link)
    if test -z "$template"; or not test -e $template
        echo "Template symlink is broken: $template_link" >&2
        return 1
    end

    set -l disk ~/vms/$name.qcow2

    if test -e $disk
        echo "Disk already exists: $disk" >&2
        return 1
    end

    qemu-img create -f qcow2 -F qcow2 \
        -b $template \
        $disk
    or return

    virt-install \
        --name $name \
        --import \
        --disk $disk,format=qcow2,bus=virtio \
        --vcpus $_flag_vcpus \
        --memory $_flag_memory \
        --memorybacking access.mode=shared \
        --cpu host-passthrough \
        --os-variant opensusetumbleweed \
        --graphics spice \
        --video virtio \
        --input tablet,bus=usb \
        --input keyboard,bus=usb \
        --channel spicevmc \
        --filesystem driver.type=virtiofs,source.dir=$HOME/vmshare,target.dir=vmshare \
        --filesystem driver.type=virtiofs,source.dir=$HOME/git-public,target.dir=git-public \
        --noautoconsole
    or return

    virt-manager --connect qemu:///session --show-domain-console $name
    disown
end
