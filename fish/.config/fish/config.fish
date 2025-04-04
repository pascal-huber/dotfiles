# TODO: remove this
set -gx ANSIBLE_FORCE_COLOR 1



if status --is-login

    # XDG Environment Variables
    set -gx XDG_CACHE_HOME $HOME/.cache
    set -gx XDG_CONFIG_HOME $HOME/.config
    # set -gx XDG_CONFIG_DIR /etc/xdg/:$XDG_CONFIGDIRS_
    set -gx XDG_DATA_HOME $HOME/.local/share
    set -gx --path XDG_DATA_DIRS $XDG_DATA_HOME/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share

    # Other environment variables
    set -gx CARGO_HOME $HOME/.cargo
    set -gx PAGER "less -S"
    set -gx ANSIBLE_FORCE_COLOR 1

    # don't install plugins here but in a seperate folder
    set -gx fisher_path $XDG_DATA_HOME/fisher

    # PATH
    # FIXME: there's got to be a better way to handle paths in fish
    set -U fish_user_paths
    fish_add_path -p $HOME/git/rofi-find-files
    fish_add_path -p $HOME/bin
    fish_add_path -p $HOME/go/bin
    fish_add_path -p $HOME/.local/bin
    fish_add_path -a $HOME/adb-fastboot/platform-tools
    fish_add_path -a $HOME/git/vercors/bin/
    fish_add_path -a '/opt/texlive/2024/bin/x86_64-linux'
    fish_add_path $HOME/.cargo/bin

    # Start WM
    if test -z "$DISPLAY" && test $XDG_VTNR = 2
        exec startx
    else if test -z "$DISPLAY" && test $XDG_VTNR = 1
        # check cursor
        # set -x XCURSOR_THEME Bibata-Original-Amber
        # set -x XCURSOR_SIZE 40
        # set -x SWAY_CURSOR_THEME Bibata-Original-Amber
        # set -x SWAY_CURSOR_SIZE 40

        # TODO: check scaling chromium flag for sway
        # set -x CHROMIUM_FLAGS "--force-device-scale-factor=1"
	# set -x CHROMIUM_FLAGS "--enable-features=UseOzonePlatform --ozone-platform=wayland"

        # TODO: Do I need these?
        # set -x QT_QPA_PLATFORM wayland
        # set -x QT_QPA_PLATFORMTHEME qt5ct
        # set -x QT_WAYLAND_FORCE_DPI physical

        # Don't do this:
        # # set -x GDK_BACKEND wayland

        # TODO: find out what they do
        # set -x CLUTTER_BACKEND wayland
        # set -x WLR_DRM_NO_MODIFIERS 1

        # Run firefox with wayland
        set -x MOZ_ENABLE_WAYLAND 1

        # Start sway with dbus session bus
        exec dbus-run-session sway
    end
end


# Commands to run in interactive sessions (with keyboard & stuff)
if status is-interactive

    # Don't show a greeting message
    set -U fish_greeting

    # Keybindings
    function fish_user_key_bindings

        # Ctrl-space to complete
        bind -k nul 'forward-char'

    end
end
