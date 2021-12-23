
# Yay! High voltage and arrows!
# shamelessly stolen and modified from oh-my-zsh

# use antigen reset when changing this

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}|%{$fg[yellow]%}★%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='%{%(?..%{$fg[red]%}exit %?%{$reset_color%}'$'\n)$fg[yellow]%}%1~%{$reset_color%}%{$fg[red]%}|%{$reset_color%}$(git_prompt_info)%{$fg[cyan]%} '$'$fg[green]\n❯ %{$reset_color%}'
