#!/usr/bin/env bash

# TODO: make it possible to leave field empty

PDF="$1"

# exit if pdf doesn't exist
if [ ! -f "$PDF" ]; then
    echo "Yo! What did you expect me to do? You need to give me a pdf!"
    exit 1
fi

# read values from pdf
default_title=$(exiftool -b -Title "$PDF")
default_subject=$(exiftool -b -Subject "$PDF")

# default author, set with: chfn -f "Joe Blow" jblow
default_author=$(getent passwd $(whoami)| cut -d ':' -f 5)

# query new title
exec 3>&1;
newtitle=$(dialog --inputbox "Title:" 0 0 "$default_title" 2>&1 1>&3)
newsubject=$(dialog --inputbox "Subject:" 0 0 "$default_subject" 2>&1 1>&3)
newauthor=$(dialog --inputbox "Author:" 0 0 "$default_author" 2>&1 1>&3)

echo $newtitle
echo $newauthor

# set attributes
if [ "" != "$newtitle" ]; then
    exiftool -Title="$newtitle" "$PDF"
fi
if [ "" != "$newsubject" ]; then
    exiftool -Subject="$newsubject" "$PDF"
fi
if [ "" != "$newauthor" ]; then
    exiftool -Author="$newauthor" "$PDF"
fi
