# History
export HISTSIZE=1000000
export HISTFILESIZE=2000000
export HISTTIMEFORMAT='%F %T '
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend

# Set terminator as a default TERMINAL
export TERMINAL="/usr/bin/urxvt"

# Set vi as default editor
export EDITOR="vi"

# Set vi as visual editor
export VISUAL="vi"

# Define the type of running terminal
# avoid define if possible
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
alias v="vim"
alias nocomment="grep -Ev '^(#|$)'"
alias public-ip="dig +short myip.opendns.com @resolver1.opendns.com"

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
  echo -ne "\033]0;$*\007"
}

function ssh {
  wname="$(echo "$*" | cut -d '.' -f 1)"
  if [ -v TMUX ]; then
    tmux rename-window "${wname}"
  fi
  title "${wname}"
  command ssh "$@"
  title "bash"
  if [ -v TMUX ]; then
    tmux rename-window "bash"
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

# start tmux if not running
if ! [ -v TMUX ]; then
  # shellcheck disable=SC2091
  if $(tmux has-session -t main); then
    tmux attach-session -t main
  else
    tmux new-session -s main
  fi
fi
