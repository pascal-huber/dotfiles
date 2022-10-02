
# Run all sh scripts in /etc/X7/xinit/xinitrc.d/
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# wrong place?
# export XDG_CONFIG_HOME=$HOME/.config

# Desktop Bus
# TODO: should I use dbus-run-session? If yes, where is $DBUS_SESSION_BUS_ADDRESS?
eval "$(dbus-launch --auto-syntax --exit-with-session)"

# Keyring Unlocking (in combination with PAM)
# source: https://wiki.archlinux.org/title/GNOME/Keyring#xinitrc
eval $(/usr/bin/gnome-keyring-daemon --start | string split "=")
export SSH_AUTH_SOCK

# SSH Agent
eval $(ssh-agent)

# Set keyboard layout
setxkbmap -layout us -variant altgr-intl

# udpate applications
update-desktop-database $HOME/.local/share/applications

# Settings
# setxkbmap -layout us -variant altgr-intl &
xbindkeys &
(xrdb ~/.Xdefaults && xrdb -merge ~/.Xresources-colors-dark) &

# Display settings
number_of_screens="`xrandr -q | grep ' connected' | wc -l`"
if [ "$number_of_screens" -gt 1 ]; then
  dohome &
else
  unhome &
fi

# Applications
compton -b &
emacs --daemon &
nm-applet &
blueman-applet &
redshift-gtk &
ThreemQT &
antimicrox --hidden &
(pipewire & sleep 1 && pipewire-pulse) &

# elogind sends a dbus message and xss-lock will fire
# xset -dpms; xset s off # no automatic locking
# xss-lock -- i3lock -c 000000 &

# Applications with delay
sleep 8 && nextcloud &

# Start Window Manager
ttyPath=$(tty)
case $ttyPath in
  *3*     )   exec herbstluftwm;;
  *4*     )   exec start-lumina-desktop;;
  *5*     )   exec startxfce4;;
  *       )   exec i3;;
esac
