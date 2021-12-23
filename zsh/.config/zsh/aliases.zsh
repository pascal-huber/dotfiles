# sudo
alias s="sudo"

# alias ssh="TERM=xterm ssh"

# Clear completely
alias cls='printf "\033c"'

# ls with colors
alias ls='ls --color=auto'

# ls order by date
alias lsd='ls -latrh'

# ls all
alias l='ls -lah'

# List symlinks
alias lssym='ls -l `find . -maxdepth 1 -type l -print`'

# ix.io (command line pastebin)
# usage: echo "echo hi" | ixio
# append `/language` to the url for syntax highlighting
alias ixio="curl -F 'f:1=<-' ix.io"

# Shutdown
alias sdn='loginctl poweroff'

# Emacs
alias e='emacsclient -nc'
alias em='emacsclient -nw'

# Vim
alias vim='nvim'

# weechat
alias irc="ssh -t irc 'tmux -L weechat attach'"
alias ircext="ssh -t piext 'tmux a'"

# Weather
alias weather-zh="curl wttr.in/Zurich"

# save youtube video to mp3
alias youtube-mp3='youtube-dl --extract-audio --audio-format mp3 --audio-quality 0'
alias youtube-playlist='youtube-dl --extract-audio --audio-format mp3 -o "%(title)s.%(ext)s"'

# directory aliases
alias dl='cd ~/Downloads'
alias qs='cd ~/git/quickshift'

# sbb
alias sbb='fahrplan'

# Go to git root folder
alias home='cd `git rev-parse --show-toplevel`'

# Git
alias ga='git add'
alias gc='git commit'
alias gs='git status'

gl_dateformat="%d.%m.%y %H:%M"

# Short git log graph
gl_format="%C(red)%h%C(reset) - %C(bold)%s%C(reset) %C(green)[%cd] %C(blue)[%an]"
alias gl="git log --color \
                  --pretty=format:'${gl_format}' \
                  --date=format:'${gl_dateformat}'"

# Long git status (with committer and author)
gll_format="%C(blue)%h - c[%cd - %cn]%C(reset) \
%C(green)a[%ad - %an]%C(reset)%n\
%C(yellow)  %s"
alias gll="git log --color \
                   --pretty=format:'${gll_format}' \
                   --date=format:'${gl_dateformat}'"


# Magit
alias mgs="emacsclient -nw -e '(magit-status)'"
alias mgl="emacsclient -nw -e '(magit-log)'"

# open things
alias o='xdg-open'
