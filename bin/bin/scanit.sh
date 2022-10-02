#!/bin/bash
# Author:    Pascal Huber

# TODO: add argument to set DEVICE
# TODO: add argument to specify output file name
# TODO: add argument to set pdf attributes
# TODO: add argument to disable compression

show_help(){
    cat <<EOF
Usage: $(basename "$0") [OPTION]... [FILE]
Scanning wrapper around scanimage

Options:
  -f, --flatbed           Use the flatbed instead of the feeder
  -h, --help              Show this help message
  -r, --resolution=VALUE  Set dpi (default: 300)
  -s, --size=VALUE        Format of input (A4,A5,100x100,...)

If no FILE is specified, it will be saved as scan.pdf or scan-x.pdf for the
lowest integer x such that no file will be overwritten.

EOF
}

# Default Settings
SIZE="A4"
RESOLUTION=300
SOURCE="Automatic Document Feeder(centrally aligned)"
DEVICE="brother4:net1;dev0"

# Process args
while [ -n "$1" ]; do
    case $1 in
        -d)
            RESOLUTION="$2"
            shift 2
            ;;
        -dpi=*)
            RESOLUTION="${1#*=}"
            shift
            ;;
        -f|--flatbed)
            SOURCE="FlatBed"
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        -s)
            SIZE="$2"
            shift 2
            ;;
        -size=*)
            SIZE="${1#*=}"
            shift
            ;;
        *)
            if [ "$#" -ne 1 ]; then
                echo "error: invalid argument: $1"
                exit 1
            else
                shift
            fi
            ;;
    esac
done

# Set correct format from given size
if [[ "$SIZE" =~ [0-9]*x[0-9]* ]]; then
    X="${SIZE%%x*}"
    Y="${SIZE##*=}"
else
    case "$SIZE" in
        A4)
            X="210"
            Y="297"
            ;;
        *)
            echo -e "invalid size\n"
            show_help
            exit 1
            ;;
    esac
fi

# Check dpi value
if [[ ! "$RESOLUTION" =~ [0-9]* ]]; then
    echo -e "invalid dpi\n"
    show_help
    exit 1
fi

# create temporoary directory
tmpdir=$(mktemp -d /tmp/scanit.XXXXXXX)
cd "${tmpdir}"
echo "dir: $tmpdir"

# Scan a tiff (and exit if it fails)
set +e
scanimage \
    --progress \
    --batch \
    --device-name="$DEVICE" \
    --resolution="$RESOLUTION" \
    --source="$SOURCE" \
    --format="tiff" \
    -x "$X" \
    -y "$Y"
    # --verbose
set -e

# merge tiff files
files=$(ls *.tf | sort -V | tr '\n' ' ')
tiffcp -c lzw $(echo $files) scan.tiff

# create pdf
tiff2pdf -z ${tmpdir}/scan.tiff > "${tmpdir}/scan.pdf"

# copmress
/bin/gs \
    -sDEVICE=pdfwrite \
    -dCompatibilityLevel=1.4 \
    -dPDFSETTINGS=/prepress \
    -dNOPAUSE \
    -dQUIET \
    -dBATCH \
    -sOutputFile="${tmpdir}/scan_compressed.pdf" \
    "${tmpdir}/scan.pdf"

# go back
cd -

# determine file name
name="scan"
if [[ -e $name.pdf || -L $name.pdf ]] ; then
    i=0
    while [[ -e $name-$i.pdf || -L $name-$i.pdf ]] ; do
        ((i=i+1))
    done
    name=$name-$i
fi

# create pdf file
cp "${tmpdir}/scan_compressed.pdf" "./${name}.pdf"

# set attributes
read -r -p "Set attributes? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    pdfattr "./${name}.pdf"
fi
