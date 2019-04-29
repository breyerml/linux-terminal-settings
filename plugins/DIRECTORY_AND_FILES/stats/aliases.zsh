# title           : stats/aliases.zsh
# description     : This file provides aliases to display file and directory statistics.
# date            : 2019-04-29
# dependencies    : ncdu
# zsh_version     : 5.7.1
# ====================================================================================


# show statistics for directories
if (( $+commands[ncdu] )) ; then
  # use 'ncdu' as 'du' alternativ
  alias dud='ncdu'
  alias duf='ncdu'
fi
