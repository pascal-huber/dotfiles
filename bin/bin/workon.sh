#!/bin/fish

if test (count $argv) -lt 0;
    echo "no name provided."
    exit 1
end

set file $HOME/.virtualenvs/$argv[1]/bin/activate.fish
if test -f $file
    echo "activating $file";
    source $file;
else
    echo "no such virtualenv: $argv[1]"
    exit 1
end
