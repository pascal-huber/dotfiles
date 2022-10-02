#!/bin/bash

# TODO: write usage
#
# TODO: image size must be mod 10, s.t. factor of x.y is integral

LOGO_SCALE="0.8"

image="$1"
shift 1
[ -f "$image" ] || exit 1

# Get image dimensions
imagewidth=$(identify -format '%w' "$image")
imageheight=$(identify -format '%h' "$image")
# min=$(echo $((imagewidth>imageheight ? imageheight : imagewidth)))
# logosize=$((8*min/10))

tmpdir=$(mktemp -d /tmp/bgmaker.XXXXXXX)

cp "$image" "$tmpdir"
imagename=$(basename "$image")

cd "$tmpdir" || exit 1

# create void mask
logo="void.svg"
wget "https://raw.githubusercontent.com/lukas-w/font-logos/master/vectors/${logo}"
logowidth=$(identify -format '%w' "$logo")
logoheight=$(identify -format '%h' "$logo")
factor_w=$((imagewidth / logowidth))
factor_h=$((imageheight / logoheight))
logo_scale_factor=279
if [ $factor_w -lt $factor_h ]; then
    logo_scale_factor=$(echo "$LOGO_SCALE * $imagewidth / $logowidth" | bc -l)
else
    logo_scale_factor=$(echo "$LOGO_SCALE * $imageheight / $logoheight" | bc -l)
fi
logo_scale_factor=$(printf "%.1f" "$logo_scale_factor")
new_logo_width=$(echo "$logo_scale_factor * $logowidth" | bc -l)
new_logo_width=$(printf "%.0f\n" "$new_logo_width")
new_logo_height=$(echo "$logo_scale_factor * $logoheight" | bc -l)
new_logo_height=$(printf "%.0f\n" "$new_logo_height")

echo "------------------"
echo "temp dir         : $tmpdir"
echo "image width      : $imagewidth"
echo "image height     : $imageheight"
echo "logo width       : $logowidth"
echo "logo height      : $logoheight"
echo "logo scale f.    : $logo_scale_factor"
echo "new logo width   : $new_logo_width"
echo "new logo height  : $new_logo_height"

# scale the logo to ??
rsvg-convert \
    -a \
    -w "${new_logo_width}" \
    "${logo}" > void-logo-scaled.png

# ??
convert \
    -background white \
    -resize "${new_logo_width}x${new_logo_height}" \
    -gravity center \
    -extent "${imagewidth}x${imageheight}" \
    void-logo-scaled.png \
    void-logo-mask.png

    # -level 10% \
    # -brightness-contrast 10x0 \
convert "${tmpdir}/${imagename}" \
    -mask void-logo-mask.png \
    -blur 0x20 \
    +level 20% \
    -brightness-contrast 10x0 \
    "${@}" \
    +mask \
    "${tmpdir}/background-${imagename}"

cd -
cp "${tmpdir}/background-${imagename}" .
