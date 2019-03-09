if [[ -z $CUSTOM_ZSH_ROOT ]]; then
        export CUSTOM_ZSH_ROOT="$( cd "$(dirname "$0")" ; pwd -P )"
fi

# ==== google chrome ====
alias chrome='google-chrome >/dev/null 2>&1'
alias chrome-stable='google-chrome-stable >/dev/null 2>&1'




alias sudo='sudo '

function command_exists() {
    if ! [ -x "$(command -v $1)" ]; then
        return 1
    fi
}
function file_exists() {
    if ! [ -f $1 ]; then
        return 1
    fi
}
function has_elevated_privileges() {
    if ! sudo -v &>/dev/null ; then
        echo "NO ELEVATED PRIVILEGES"
        return 1
    fi
}


if file_exists $CUSTOM_ZSH_ROOT/aliases/directory.zsh ; then
    source $CUSTOM_ZSH_ROOT/aliases/directory.zsh
fi
if file_exists $CUSTOM_ZSH_ROOT/aliases/hardware.zsh ; then
    source $CUSTOM_ZSH_ROOT/aliases/hardware.zsh
fi




# ==== grep ====
alias grep='grep --color=always'            # color normal grep output
alias egrep='egrep --color=always'          # color egrep output
alias fgrep='fgrep --color=always'          # color fgrep output
alias rgrep='rgrep --color=always'          # color rgrep output

# === git ====
alias gits='git status'                                     # show git status message
alias gitd='git diff --color=always'                        # show git difference with colors
alias gitc='git commit -m'                                  # commit staged changes
alias gita='git add -A'                                     # add all untracked and/or changed files
alias gitac='git commit -am'                                # add all untracked and/or changed files and commit them
alias gitl='git log --graph --abbrev-commit --decorate'     # show log as graph with abbreviated commit ids


# ==== others ====
alias bc='bc -ql'                           # don't print bc welcome and use math library
alias wget='wget -c'                        # continue wget in case of error
# Parenting changing perms on / #
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'


alias path='echo -e ${PATH//:/\\n}'         # list all PATH variables
alias manpath='echo -e ${MANPATH//:/\\n}'   # list all MAN_PATH variables
alias ld_library_path='echo -e ${LD_LIBRARY_PATH//:/\\n}'   # list all LD_LIBRARY_PATH variables
alias pkg_config_path='echo -e ${PKG_CONFIG_PATH//:/\\n}'   # list all PKG_CONFIG_PATH variables
alias diff='colordiff'                      # always diff with colors
alias goodnight='shutdown -h now'           # shutdown computer


# ==== misc ====
alias today='date "+"'

# ==== colorfull man pages ====
export LESS_TERMCAP_mb=$'\e[1;31m'        # begin blinking
export LESS_TERMCAP_md=$'\e[1;38;5;136m'  # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\e[38;5;254m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export LESS_TERMCAP_us=$'\e[4;38;5;64m'   # begin underline
