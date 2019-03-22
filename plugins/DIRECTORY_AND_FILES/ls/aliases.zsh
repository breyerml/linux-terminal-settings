# title           : ls/aliases.zsh
# description     : This file provides various aliases to the ls command.
# date            : 2019-03-22
# dependencies    : -
# zsh_version     : 5.7.1
# ====================================================================================

eval "$(dircolors $(cd "$(dirname "$0")" ; pwd -P)/dircolors)"

# color output if possible and change time stamp to (e.g.): 2019-03-05 18:48:51
alias ls='ls --color=auto --time-style=+"%Y-%m-%d %H:%M:%S"'  

alias la='ls -A'                            # list all files (including hidden ons, excluding . and ..)
alias l.='ls -Ad .?*'                       # list hidden files only
alias l='ls -lAh'                           # list all files with details
alias ll='ls -lh'                           # list non-hidden files with details
alias lp='ls -d "$(pwd)"/*'                 # list non-hidden files with full path
alias lr='ls -lRh'                          # list non-hidden files recursively
alias lc='ls | wc -l'                       # count all non-hidden files
alias lac='ls -A | wc -l'                   # count all files
alias lf='ls -hAF | \egrep'                 # find all files with the given pattern
alias lt='ls -Alht'                         # list all files sorted by time (newest first)
alias ltr='ls -Alhtr'                       # list all files sorted by time (oldest first)
alias lss='ls -AlhS'                        # list all files sorted by size (biggest first)
alias lssr='ls -AlhSr'                      # list all files sorted by size (smallest first)
alias lne='ls -d -- ^?*.*(D.)'              # list all files without extensions