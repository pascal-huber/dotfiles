# Inspired by:
# rocketman

function build_prompt() {
  local LAST_EXIT_CODE=$?

  local EXIT_LINE="%{$reset_color%}"
  local STATUS_LINE="%{$reset_color%}"
  local PROMPT_LINE="%{$reset_color%}"

  # Handle last exit code
  if [[ $LAST_EXIT_CODE -ne 0 ]]; then
    EXIT_LINE+="%{$fg_bold[red]%} -- exit $LAST_EXIT_CODE\n"
    PROMPT_LINE+="%{$fg_bold[yellow]%}"
  fi
  # 

  # Status line
  STATUS_LINE+="%{$fg_bold[cyan]%}%c$(git_prompt)\n"

  # Prompt
  PROMPT_LINE+=" ❯ "

  echo $EXIT_LINE$STATUS_LINE$PROMPT_LINE
}

function git_prompt() {
  INDEX=$(git status --porcelain 2> /dev/null)
  GIT=$?
  STATUS=""

  if [ ! 0 -eq $GIT ] ; then
    return
  fi

  # is branch ahe # is branch ahead?
  if $(echo "$(git log origin/$(git_current_branch)..HEAD 2> /dev/null)" | grep '^commit' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_AHEAD"
  fi

  # is anything staged?
  if $(echo "$INDEX" | command grep -E -e '^(D[ M]|[MARC][ MD]) ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STAGED"
  fi

  # is anything unstaged?
  if $(echo "$INDEX" | command grep -E -e '^[ MARC][MD] ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNSTAGED"
  fi

  # is anything untracked?
  if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED"
  fi

  # is anything unmerged?
  if $(echo "$INDEX" | command grep -E -e '^(A[AU]|D[DU]|U[ADU]) ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNMERGED"
  fi

  # I the current directory the git project root?
  if [[ ! -d .git ]]; then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_NONROOT"
  fi

  branch=" %{$fg[yellow]%} $(git_current_branch)"
  echo "${branch} $STATUS"

}

ZSH_THEME_PROMPT_RETURNCODE_PREFIX="%{$fg_bold[red]%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[red]%}  "
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[green]%}●"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg_bold[yellow]%}●"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[red]%} "
ZSH_THEME_GIT_PROMPT_NONROOT="%{$fg_bold[red]%} "
ZSH_THEME_GIT_PROMPT_SUFFIX=" $fg_bold[white] › %{$reset_color%}"

PROMPT='$(build_prompt) '
# ●
