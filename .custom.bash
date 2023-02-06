# History
function _bash_history_sync {
  builtin history -a
  HISTFILESIZE=$HISTSIZE
  builtin history -c
  builtin history -r
}

HISTSIZE=1000000
HISTFILESIZE=2000000
# HISTTIMEFORMAT and ignoredups:erasedups are not compatible
HISTTIMEFORMAT='%F %T '
# HISTCONTROL=ignoredups:erasedups

# Fix to avoid login shells truncate the history
HISTFILE="$HOME/.bash_thistory"
shopt -s histappend

# After each command, append to the history file and reread it
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}_bash_history_sync"

# Set terminator as a default TERMINAL
# export TERMINAL="/usr/bin/urxvt"
export TERMINAL="/home/manuel/bin/alacritty"

# Set vi as default editor
export EDITOR="vi"

# Set vi as visual editor
export VISUAL="vi"

# Define the type of running terminal
# avoid define it if possible
# export TERM="xterm-256color"

# Set less as default PAGER
export PAGER="less"

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\e[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline

# Pass (password-store) completion
# shellcheck disable=SC1091
source /usr/share/bash-completion/completions/pass

# Show directories/files with more disk use
function dumax {
  du -mx "$1" | sort -nr \
    | awk '{ if ($1 >= 1000) printf "%s => %0.2f G\n", $2, ($1/1024)
             else printf "%s => %s M\n", $2, $1 }' \
    | head -20
}

# Some useful aliases
alias dist-upgrade="sudo apt-get update && sudo apt-get dist-upgrade"
alias mnt="mount | column -t"
alias path='echo -e ${PATH//:/\\n}'
alias c="clear"
alias p="ps auxf"
alias nocomment="grep -Ev '^(#|$)'"
alias public-ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias weather="curl http://wttr.in?format=3"

# List Debian installed (and unused) kernels
function kernels {
  dpkg -l \
    | awk '{ if ($2 ~ /^linux-image-[0-9].*/) {
               printf("%s ", $2)
             }
           }
           END { print "" }' \
    | sed "s/linux-image-$(uname -r)//g"
}

# Use colors highlight
alias diff="colordiff"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias rgrep="rgrep --color=auto"

# Going up cwd
alias cd..="cd .."
alias ..="cd .."
alias ...="cd ../../../"
alias ....="cd ../../../../"

# Change directory and list files
function cdl {
    cd "$@" || return
    ls
}

# Manage window title
function title {
  # shellcheck disable=SC1003
  printf '\033k%s\033\\' "$*"
}

function ssh {
  wname="$(echo "$*" | awk '{ print $NF }')"
  if [ -v TMUX ]; then
    tmux rename-window "${wname}"
  fi
  title "${wname}"
  command ssh "$@"
  title "${HOSTNAME}"
  if [ -v TMUX ]; then
    tmux rename-window "${HOSTNAME}"
  fi
}

# fasd initialization
fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" ] || ! [ -s "$fasd_cache" ]; then
  fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
fi
# shellcheck disable=SC1090
source "$fasd_cache"
unset fasd_cache

# Powerline configuration
export POWERLINE_BASH_CONTINUATION=1
export POWERLINE_BASH_SELECT=1
# shellcheck disable=SC1091
source /usr/share/powerline/bindings/bash/powerline.sh

# fzf
# shellcheck disable=SC1091
source /usr/share/doc/fzf/examples/key-bindings.bash

# start tmux if not running
if ! [ -v TMUX ]; then
  # shellcheck disable=SC2091
  if $(tmux has-session -t main); then
    tmux attach-session -t main
  else
    tmux new-session -s main
  fi
fi

# edit given file or search in recently used files
function v {
  local file
  # if arg1 is a path to existing file then simply open it in the editor
  test -e "$1" && $EDITOR "$@" && return
  # else use fasd and fzf to search for recent files
  file="$(fasd -Rfl "$*" | fzf -1 -0 --no-sort +m)" && $EDITOR "${file}"
}
