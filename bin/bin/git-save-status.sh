#!/bin/bash

git checkout -b "$1"
git add .
git commit -m "$2"

echo "created branch $1 for $2"

# go back to other branch
git checkout -
