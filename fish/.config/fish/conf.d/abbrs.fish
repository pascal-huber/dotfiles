#!/usr/bin/env fish

if not set -q fish_initialized

    # ls
    abbr -a lsd ls -latrh
    abbr -a l ls -lah
    abbr -a lssym 'ls -l (find . -maxdepth 1 -type l -print)'

    # places
    abbr -a dl cd ~/Downloads

    # save youtube video to mp3
    abbr -a youtube-mp3 'yt-dlp --extract-audio --audio-format mp3 --audio-quality 0'
    abbr -a youtube-playlist 'youtube-dl --extract-audio --audio-format mp3 -o "%(title)s.%(ext)s"'

    # Git shortcuts
    abbr -a gh 'cd (git rev-parse --show-toplevel)'
    abbr -a ga 'git add'
    abbr -a gc 'git commit'
    abbr -a gs 'git status'

    # alias gl="git log --color --pretty=format:'%C(red)%h%C(reset) - %C(bold)%s%C(reset) %C(green)[%cd] %C(blue)[%an]' --date=format:'%d.%m.%y %H:%M'"
end
