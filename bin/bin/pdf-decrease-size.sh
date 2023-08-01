#!/bin/bash
#
# Reduces the size of a pdf to a reasonable size
#
# Usage: pdf-decrease-size pdfs...

# options: /default, /prepress, /printer, /ebook, /screen
QUALITY="/printer"

for f in "$@"; do
    echo "$f"
    gs \
        -sDEVICE=pdfwrite \
        -dCompatibilityLevel=1.4 \
        -dPDFSETTINGS=$QUALITY \
        -dNOPAUSE \
        -dQUIET \
        -dBATCH \
        -sOutputFile=- \
        "$f" | sponge "$f"
done
