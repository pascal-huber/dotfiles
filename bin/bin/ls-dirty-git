#!/bin/bash

cd "${HOME}/git/"

for dir in */; do
    cd "${HOME}/git/${dir}"

    if [ ! -d ".git" ]; then
        echo "${dir} has no git..."
    elif  [[ -n $(git status -s) ]]; then
        echo "${dir} has dirty git"
    fi

done
