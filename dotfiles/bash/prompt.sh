
PROMPT_COMMAND=prompt_command

RESET='\[\e[0m\]'
RED='\[\e[0;31m\]'
GREEN='\[\e[0;32m\]'
YELLOW='\[\e[0;33m\]'
BLUE='\[\e[0;34m\]'
CYAN='\[\e[0;36m\]'
B_ORANGE='\[\e[1;31m\]'

# extract branch name or commit hash from git output
function git_location() {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    echo "${BASH_REMATCH[1]}"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "#$commit"
  fi
}

function git_prompt {
  # fail fast if current folder is not a git repository
  git -C $PWD rev-parse > /dev/null 2>&1 || exit 1

  # The main command. All the content is derived from the output of this command
  local git_status="$(git status 2> /dev/null)"

  local color=$([[ $git_status =~ "clean" ]] && echo "$GREEN" || echo "$B_ORANGE")
  
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"
  if [[ $git_status =~ $on_branch ]]; then
    local location="$color${BASH_REMATCH[1]}"
  elif [[ $git_status =~ $on_commit ]]; then
    local location="$color#${BASH_REMATCH[1]}#"
  fi
  
  local markers=""

  if [[ $git_status =~ "Your branch is ahead of ".*" by "([[:digit:]]*) ]]; then
    markers+=" ${BASH_REMATCH[1]}⇑"
  fi
  if [[ $git_status =~ "Untracked files" ]] || [[ $git_status =~ "Changes not staged" ]]; then
    markers+=" *"
  fi
  
  echo -e "($color$location$RESET$markers)"
}

function kube_prompt() {
  kubectl config current-context >/dev/null 2>&1 || exit 1

  echo -ne "($(kubectl config current-context))"
}

prompt_command() {
  local last_exit="$?"

  PS1=""

  # Last command result
  [ $last_exit -ne 0 ] && PS1+="➣➣➣ $RED$last_exit$RESET\n"
  # Time
  PS1+="$BLUE\A$RESET "
  # Location (only if remote)
  [ -z ${ITERM_PROFILE} ] && PS1+="$B_ORANGE<\h>$RESET "
  # Current folder
  PS1+="$CYAN[\w]$RESET "
  # Git prompt
  PS1+="$(git_prompt)"
  # Current kubernetes clusters
  PS1+="$(kube_prompt)"

  PS1+="$ "
}
