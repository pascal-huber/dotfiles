#!/bin/bash

DIR=$(dirname "$(readlink -f "$0")")
TARGET_DIR="${HOME}/bin"

mkdir -p "$TARGET_DIR"

FILES="${DIR}/*"
for filepath in ${FILES} ; do
  filename=$(basename "$filepath")
  if [ ! "$filename" = "$0" ]; then
    linkname=${filename%.*}
    echo "${linkname} -> ${DIR}/${filename}"
	  ln -sf "${DIR}/${filename}" "${TARGET_DIR}/${linkname}"
  fi
done
