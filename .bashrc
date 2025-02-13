###########################
# Setting variables
###########################

if [ -f /opt/homebrew/bin/brew ]; then
  PATH="/opt/homebrew/bin:$PATH"
fi
PTS_WORKDIR="~"
PTS_WELCOME="false"

###########################
# Setting aliases
###########################

alias ll="ls -lah --color=auto"
alias cdd="cd $PTS_WORKDIR"

if type kubectl &> /dev/null; then
  if type kubecolor &> /dev/null; then
    alias kk="kubecolor"
    alias k="kubecolor"
  else
    alias kk="kubectl"
    alias k="kubectl"
  fi
fi

if type git &> /dev/null; then
  alias push="git push origin"
  alias commit="git commit"
fi

###########################
# Setting completions
###########################

if [ -f /usr/share/bash-completion/bash_completion ]; then
  source /usr/share/bash-completion/bash_completion
fi

if type brew &> /dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"* ; do
    [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
  done
fi

if type kubectl &> /dev/null; then
  source <(kubectl completion bash)
  complete -o default -F __start_kubectl k
fi

###########################
# Setting history settings
###########################


HISTTIMEFORMAT="%d/%m/%y %T "
HISTIGNORE="ls:ll:cd:pwd:bg:fg:history"
HISTSIZE=10000
HISTCONTROL=ignoreboth

if [[ $- == *i* ]]
then
  bind '"\e[A": history-search-backward'
  bind '"\e[B": history-search-forward'
fi


###########################
# Setting prompt
###########################


PROMPT_COMMAND=__prompt_command

__prompt_command() {
  export PTS_EXIT_CODE="$?"
  PS1=''

  local RCol='\[\e[0m\]'

  local Red='\[\e[0;31m\]'
  local Gre='\[\e[0;32m\]'
  local BYel='\[\e[1;33m\]'
  local BBlu='\[\e[1;34m\]'
  local Pur='\[\e[0;35m\]'

  if [ $PTS_EXIT_CODE == "0" ] || [ $PTS_EXIT_CODE == "130" ]; then
    PS1+='\[\e[1;32;44m\] $(echo -n -e "\xe2\x9c\x85"; printf " %-3s " $PTS_EXIT_CODE)'
  else
    PS1+='\[\e[1;31;44m\] $(echo -n -e "\xe2\x9d\x8c"; printf " %-3s " $PTS_EXIT_CODE)'
  fi

  PS1+='\[\e[1;37;44m\] $(echo -n -e "\xf0\x9f\x95\x91") [\d \t] \[\e[1;30;43m\] \u@\H \[\e[1;37;45m\] $(echo -e "\xf0\x9f\x93\x81") \w \[\e[1;32;46m\]$(if if type git &>/dev/null && git status &>/dev/null; then echo -n -e " \xf0\x9f\x94\x97 ("; echo -n "$(git branch --show-current)"; if [[ $(git status -s | wc -l) -ne 0 ]]; then echo -n " *"; fi; echo -n ") "; fi)\[\e[0;0;0m\]\n>> '
}


###########################
# Setting welcome message
###########################

if $PTS_WELCOME; then
  printf "\n"
  printf "   %s\n" "USER: $(whoami)"
  printf "   %s\n" "DATE: $(date)"
  printf "   %s\n" "UPTIME: $(uptime -p)"
  printf "   %s\n" "HOSTNAME: $(hostname -f)"
  printf "   %s\n" "KERNEL: $(uname -a)"
  printf "   %s\n" "MEMORY: $(free -m -h | awk '/Mem/{print $3"/"$2}')"
  printf "   %s\n" "BASH: $(bash --version | head -n 1)"
  printf "\n"
fi

