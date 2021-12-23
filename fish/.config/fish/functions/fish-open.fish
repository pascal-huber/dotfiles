#!/usr/bin/env fish

function fish-open --description 'Open things'
    for i in (seq 1 (count $argv));
        xdg-open "$argv[$i]" & disown
        # if test -r "$argv[$i]"
        #     xdg-open "$argv[$i]" & disown
        # else
        #     echo "can't open file: $argv[$i]"
        #     xdg-open "$argv[$i]" & disown
        # end
    end
end
