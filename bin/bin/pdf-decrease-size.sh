
files=$(find . -iname "*.pdf");
for f in $files; do
    echo "$f"
    gs \
        -sDEVICE=pdfwrite \
        -dCompatibilityLevel=1.4 \
        -dPDFSETTINGS=/prepress \
        -dNOPAUSE \
        -dQUIET \
        -dBATCH \
        -sOutputFile=- \
        "$f" | sponge "$f"
done
