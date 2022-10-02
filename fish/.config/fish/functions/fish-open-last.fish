#!/usr/bin/env fish

# complete file names sorted by change time
complete -c fish-open-last \
    -f \
    -a "(ls -ct)" \
    --keep-order

function fish-open-last --description 'Open most recent thing'
    if test (count $argv) = 0;
        set last (ls -c | head -n 1)
        if test -d $last;
            cd $last
        else
            fish-open $last
        end
    else
        fish-open $argv
    end
end
