#!/usr/bin/env fish

if not set -q fish_initialized

    alias smplayer='flatpak run --env=QT_QPA_PLATFORM= info.smplayer.SMPlayer'

    # clear including scrollback
    alias cls='printf "\033c"'

    # ixio
    alias ixio="curl -F 'f:1=<-' ix.io"

    # shutdown
    alias sdn='loginctl poweroff'

    # Emacs
    alias e='emacsclient -nc'
    alias em='emacsclient -nw'

    # Vim
    alias vim='nvim'

    # Weechat
    alias irc="TERM=xterm-256color /bin/ssh -t irc 'tmux -L weechat attach'"

    # SSH
    alias ssh="TERM=xterm-256color /bin/ssh"

    # Open stuff
    alias o='fish-open'

    # Most recent file interactions
    alias ol='fish-open-last'

end
