#!/bin/bash

show_usage()
{
	cat <<EOF
  Usage:
    List files: $(basename $0) list DIRECTORY [RG-OPTIONS]
    Open file:  $(basename $0) open FILE
  Either lists all files in the given directory with rg or opens the given file
  with the default application.
  Example usage with rofi:
    Call: rofi -show eth -modi eth:~/bin/eth-files,private:~/bin/private-files
    ~/bin/eth-files:
      #!/bin/bash
      DIRECTORY="${HOME}/cloud/eth/"
      if [ \$# -eq 0 ]; then
        rofi-files list "\${DIRECTORY}"
      else
        rofi-files open "\${DIRECTORY}/\${1}"
      fi
    ~/bin/private-files:
      #!/bin/bash
      DIRECTORY="${HOME}/cloud/"
      if [ \$# -eq 0 ]; then
        rofi-files "list" "\{$DIRECTORY}" \\
                   -g "!/eth" \\ # folder is covered by other mode
                   -g "!/bg"     # ignore this folder too
      else
        rofi-files open "\${DIRECTORY}/\${1}"
      fi
EOF
}

ACTION="$1"

# if [ "$ACTION" = "list" ]; then
#   cd "$2" || exit 1
#   rg --files --follow "${@:3}"
# elif [ "$ACTION" = "open" ]; then
#   if [ -f "$2" ]; then
#     exo-open "$2" >/dev/null 2>&1
#   else
#     notify-send "no such file: $2"
#   fi
#   exit;
# else
#   show_usage
# fi

if [ "$ACTION" = "list" ]; then
  cd "$2" || exit 1
  rg --files --follow ${@:3}
elif [ "$ACTION" = "open" ]; then
  shift
  if [ -f "$@" ]; then
    # notify-send "file: $?"
    exo-open "$@" >/dev/null 2>&1
    exit;
  else
    notify-send "[${?}] no file: ${@}"
    exit;
  fi
else
  show_usage
fi
