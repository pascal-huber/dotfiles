if status --is-login
    # fish prompt fix
    # https://github.com/IlanCosman/tide/issues/622
    set -gx tide_character_vi_icon_default "❯"

    # XDG Environment Variables
    # store data is here:
    set -gx XDG_DATA_HOME $HOME/.local/share
    # search data here:
    set -gx --path XDG_DATA_DIRS $XDG_DATA_HOME/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share
    # store configs here:
    set -gx XDG_CONFIG_HOME $HOME/.config
    # search configs here:
    # set -gx --path XDG_CONFIG_DIRS
    # state is here:
    # set -gx XDG_STATE_HOME 
    # cache is here:
    set -gx XDG_CACHE_HOME $HOME/.cache
    # store runtime here
    # set -gx XDG_RUNTIME_DIR

    # Other environment variables
    set -gx ANSIBLE_FORCE_COLOR 1
    set -gx CARGO_HOME $HOME/.cargo
    set -gx EDITOR nvim
    set -gx PAGER "less -S"

    # PATH
    set -U fish_user_paths
    fish_add_path -p $HOME/bin
    fish_add_path -p $HOME/go/bin
    fish_add_path -p $HOME/.local/bin
    fish_add_path -p $HOME/.local/share/flatpak/exports/bin
    fish_add_path -a $HOME/.cargo/bin
    fish_add_path -a /var/lib/flatpak/exports/bin

    # Never show fish greeting
    set -U fish_greeting

    # set fisher_path
    set -gx fisher_path $XDG_DATA_HOME/fisher
end

# Commands to run in interactive sessions (with keyboard & stuff)
if status is-interactive

    # Keybindings
    # NOTE: run `bind` to print all current bindings
    function fish_user_key_bindings
        # Ctrl-space to for autocomplete (alt-
        bind ctrl-space forward-char
    end

end
