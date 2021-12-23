#!/usr/bin/env fish

function fish-move-last --description 'Move most recent thing somewhere'
    if test (count $argv) = 1;
        set last (ls -ct | head -n 1)
        set dest "$argv[1]"
        if test -d $dest
            echo "$last -> $dest"
            mv $last $dest
        end
    end
end
