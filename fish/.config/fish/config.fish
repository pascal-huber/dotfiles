
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx --path XDG_DATA_DIRS $XDG_DATA_HOME/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share

set -gx CARGO_HOME $HOME/.cargo

# don't install plugins here but in a seperate folder
set -gx fisher_path $XDG_DATA_HOME/fisher

# PATH
# FIXME: there's got to be a better way to handle paths in fish
set -U fish_user_paths
fish_add_path -p $HOME/git/rofi-find-files
fish_add_path -p $HOME/bin
fish_add_path -p $HOME/.local/bin
fish_add_path -a $HOME/adb-fastboot/platform-tools
fish_add_path -a '/opt/texlive/2022/bin/x86_64-linux'
fish_add_path $HOME/.cargo/bin

# start xorg
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx
    else if test -z "$DISPLAY" -a $XDG_VTNR = 2
        set -x CHROMIUM_FLAGS "--force-device-scale-factor=1"
        set -x QT_QPA_PLATFORM wayland
        set -x QT_QPA_PLATFORMTHEME qt5ct
        set -x CLUTTER_BACKEND wayland
        set -x WLR_DRM_NO_MODIFIERS 1
        set -x MOZ_ENABLE_WAYLAND 1
        exec sway
    end
end


# Commands to run in interactive sessions (with keyboard & stuff)
if status is-interactive

    # Don't show a greeting message
    set -U fish_greeting

    # pager
    set -gx PAGER "less -S"

    # Keybindings
    function fish_user_key_bindings

        # Ctrl-space to complete
        bind -k nul 'forward-char'

    end
end
