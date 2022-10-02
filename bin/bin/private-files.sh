#!/usr/bin/env bash

# notify-send "> $? $@"

DIRECTORY="${HOME}/cloud/"
if [ $# -eq 0 ]; then
  rofi-files "list" "$DIRECTORY" \
             -g "!/eth" \
             -g "!/bg"
else
  rofi-files open "${DIRECTORY}/${1}"
fi


# #!/usr/bin/env bash

# DIRECTORY="${HOME}/cloud/"

# if [ $# -eq 0 ]; then
#   cd $DIRECTORY
#   rg --files --follow \
#      -g "!/eth" \
#      -g "!/bg"
# else
#   # shift
#   if [ -f "${DIRECTORY}${1}" ]; then
#     file="${DIRECTORY}${1}"
#     mkdir -p "~/.local/share/rofi-files/"
#     echo ${file} > "~/.local/share/rofi-files/selection"
#     exo-open "$file" >/dev/null 2>&1
#     exit;
#   else
#     notify-send "[${?}] no file: ${@}"
#   fi
# fi
