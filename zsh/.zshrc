source $HOME/.config/zsh/antigen.zsh
autoload -U add-zsh-hook

# logging
# export ANTIGEN_LOG=/home/pascal/antigen.log

# zprof gives some insight in what uses a lot of time starting zsh
# zmodload zsh/zprof

# oh-my-zsh plugins
antigen use oh-my-zsh
# antigen bundle robbyrussel/oh-my-zsh plugins/themes
antigen bundle git

# asdf version manager
antigen bundle kiurchv/asdf.plugin.zsh

# other plugins
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
# TODO: fix ssh-agent
# antigen bundle bobsoppe/zsh-ssh-agent

# too slow
export NVM_LAZY_LOAD=true
antigen bundle lukechilds/zsh-nvm

# local plugins
antigen bundle /home/pascal/.config/zsh --no-local-clone

# theme
antigen theme /home/pascal/.config/zsh/ void

antigen apply

# # load nvm automatically
load-nvm() {
  if [[ -f .nvmrc && -r .nvmrc ]] ; then
    nvm use
  fi
}
add-zsh-hook chpwd load-nvm

# .sourcme files
load-sourceme() {
  if [[ -f .sourceme && -r .sourceme ]]; then
    echo "\033[0;32mLoading .sourceme"
  	source .sourceme
  fi
}
add-zsh-hook chpwd load-sourceme

# asdf version manager

# rbenv
# eval "$(rbenv init -)"

# load-rvm() {
#   if [[ -f .ruby-version && -r .ruby-version ]] ; then
#     rvm use
#   fi
# }
# add-zsh-hook chpwd load-rvm

# zprof

# Python pyenv
# export PATH="/home/pascal/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# after conda installation:
#      conda init zsh
#      conda config --set auto_activate_base false
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/pascal/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/pascal/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/pascal/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/pascal/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# python virtualenv handling
# create virtualenv example: mkenv 3.8.0 my-project
# work on project: workon my-project
# as proposed here: https://github.com/asdf-vm/asdf/issues/636
export WORKON_HOME=$HOME/.virtualenvs
mkenv(){
    virtualenv -p $(asdf where python "$1")/bin/python "$WORKON_HOME"/"$2"
}
workon(){
    source "$WORKON_HOME"/"$1"/bin/activate
    # [ -d "$PROJECT_HOME"/"$1" ] && cd "$PROJECT_HOME"/"$1"
}

# bash completion for vpm
# TODO: fix this
if [ -f ~/git/vpm/bash-completion/completions/vpm ]; then
  autoload bashcompinit
  bashcompinit
  source  ~/git/vpm/bash-completion/completions/vpm
fi
