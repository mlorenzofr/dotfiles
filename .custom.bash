# History
HISTSIZE=1000000
HISTFILESIZE=2000000
HISTTIMEFORMAT='%F %T '

# Set terminator as a default TERMINAL
export TERMINAL="/usr/bin/terminator"

# Set vim as default editor
export EDITOR="vim"

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

# Enable git-prompt
source /etc/bash_completion.d/git-prompt
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_UNTRACKEDFILES=true
PROMPT_COMMAND="__git_ps1 '\[\e]0;\u@\h: \w\a\]\[\e[1;32m\]\u@\h\[\e[m\]:\[\e[1;34m\]\w\[\e[m\]' '$ ' ' [%s]'"

# Pass (password-store) completion
source /usr/share/bash-completion/completions/pass

# Show directories/files with more disk use
function dumax {
  du -mx $1 | sort -nr \
    | awk '{ if ($1 >= 1000) printf "%s => %0.2f G\n", $2, ($1/1024)
             else printf "%s => %s M\n", $2, $1 }\' \
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

# Taken from nixcraft thread
# If you pass no arguments, it just goes up one directory.
# If you pass a numeric argument it will go up that number of directories.
# If you pass a string argument, it will look for a parent directory with that
#    name and go up to it.
function up {
  dir=""
  if [ -z "$1" ]; then
    dir=".."
  elif [[ $1 =~ ^[0-9]+$ ]]; then
    x=0
    while [ $x -lt ${1:-1} ]; do
      dir="${dir}../"
      x=$(($x+1))
    done
  else
      dir=${PWD%/$1/*}/$1
  fi
  cd ${dir}
}

# Change directory and list files
function cdl {
    cd $@
    ls
}
