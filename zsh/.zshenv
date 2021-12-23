
##############################################
# Path
##############################################

# NVM (used in emacs)
# TODO: find a better option
# export PATH=$HOME/.nvm/versions/node/v10.6.0/bin:$PATH

export PAGER="less -S"

# Gems
# export PATH=$HOME/.rbenv/bin:$PATH

# User binaries
export PATH=$HOME/bin:$PATH

# Python
# export PATH=$HOME/.local/bin:$PATH

# Rust
# export PATH=$HOME/.cargo/bin:$PATH

export PATH=$HOME/git/rofi-find-files:$PATH

# export PATH="$PATH:node_modules/.bin"
# export PATH="$PATH:/home/pascal/.nvm/versions/node/v10.6.0/bin/"
# st
# export PATH=/usr/local/bin:$PATH

# Go
export GOPATH="$HOME/.go"
export PATH=$GOPATH/bin:$PATH

##############################################
# Arbitrary
##############################################

# export TERM=xterm-256color
# export TERM=xterm-256color
# export TERM=rxvt
# export TERM=alacritty
export TERM=rxvt-unicode-256color

export EDITOR="emacsclient"
export VISUAL="emacsclient -nw"

# export PATH="$HOME/.termite-color-switcher/bin:$PATH"

##############################################
# Scaling
##############################################

# automatically scale QT5 applications
# export QT_AUTO_SCREEN_SCALE_FACTOR=1

# scale gtk3+  (e.g. chromium)
# export GDK_SCALE=1.4

# https://grimoire.science/working-with-wayland-and-sway/
# export GDK_BACKEND=wayland
# export CLUTTER_BACKEND=wayland

##############################################
# Sway settings
##############################################

wm=$(wmctrl -m | head -n 1 | sed 's=Name: ==')
if [ "$wm" = "wlroots wm" ]; then
  export QT_QPA_PLATFORM=wayland-egl
  export QT_WAYLAND_FORCE_DPI=physical
  # export XCURSOR_SIZE=48
  # export XCURSOR_THEME=Bibata_Void_Green
  # QT_AUTO_SCREEN_SCALE_FACTOR
  # export GDK_DPI_SCALE=1.5

  # Fix nm-applet & co.
  # source https://github.com/Alexays/Waybar/issues/21
  export XDG_CURRENT_DESKTOP=sway
  # export XDG_RUNTIME_DIR=/run/user/1000
  # export XDG_SEAT=seat0
  # export XDG_SESSION_CLASS=user
  export XDG_SESSION_DESKTOP=sway
  # ??? XDG_SESSION_ID=12
  export XDG_SESSION_TYPE=wayland
  # ??? XDG_VTNR=1

  # set cursor size
  # TODO: check if setting in sway config fixed cursor size or if env variables are still needed
  # source https://github.com/swaywm/sway/issues/4610
  # export XCURSOR_SIZE=64
  # export XCURSOR_THEME=Bibata_Salmon

  # firefox for wayland
  export MOZ_ENABLE_WAYLAND=1
fi

##############################################
# Python
##############################################

# export PATH="$HOME/.poetry/bin:$PATH"

# export PATH="/home/pascal/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

export PATH="/home/pascal/miniconda3/bin:$PATH"

##############################################
# Gnome Keyring
##############################################

if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi
