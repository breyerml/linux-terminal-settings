# title           : warp/aliases.zsh
# description     : This file provides aliases to the warp function
# date            : 2019-04-20
# dependencies    : -
# zsh_version     : 5.7.1
# ====================================================================================


# don't use globbing on warp parameters
# -> be able to write warp -? to show a help message
alias warp='noglob warp'
