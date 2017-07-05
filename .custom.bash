# History
HISTSIZE=1000000
HISTFILESIZE=2000000
HISTTIMEFORMAT='%F %T '

# Set terminator as a default TERMINAL
export TERMINAL="/usr/bin/terminator"

# Set vim as default editor
export EDITOR="vim"

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\e[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline

# Pass (password-store) completion
source /usr/share/bash-completion/completions/pass

# Show directories/files with more disk use
function dumax {
  du -mx $1 | sort -nr \
    | awk '{ if ($1 >= 1000) printf "%s => %0.2f G\n", $2, ($1/1024)
             else printf "%s => %s M\n", $2, $1 }\' \
    | head -20 
}
