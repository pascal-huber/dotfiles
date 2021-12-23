#!/usr/bin/env fish

function unzip-wrapper --description 'Unzip wrapper to not make a mess'
    if not test (count $argv) = 0 && test -f $argv;
        set n (unzip -qql $argv | awk '{print $4}' | sed -e "s#\/.*##" | sort -u | wc -l)
        echo "n: $n"
        if test $n -ge 2;
            set filename (basename $argv)
            echo "dirname: ${filename%%.*}}"
            unzip -d $dirname $argv
        else
            unzip $argv
        end
    else
        echo "nope"
    end
end
