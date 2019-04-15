# title           : dot_cd/widgets.zsh
# description     : This file provides a widget to expand multiple dots in the cd command
# date            : 2019-04-14
# dependencies    : -
# zsh_version     : 5.7.1
# Based on http://stackoverflow.com/a/41420448/4757
# Based on https://github.com/parkercoates/dotfiles/blob/master/.zsh/expand-multiple-dots.zsh
# ====================================================================================


# expand multiple dots to parent directories, i.e. `cd ...<TAB>` expands to `cd ../../`
function dot-expand() {
## only expand if we are at the start of a line, wright after a space or in the middle of a path
  if [[ $LBUFFER =~ '(^| |/)\.\.\.+' ]]; then
    LBUFFER=$LBUFFER:fs%\.\.\.%../..%
  fi

  if [[ $WIDGET == 'dot-expand-and-expand-or-complete' ]]; then
    ## if TAB was entered: expand-or-complete command line arguments
    zle expand-or-complete
  elif [[ $WIDGET == 'dot-expand-and-accept-line' ]]; then
    ## if RETURN was entered: accept-line
    zle accept-line
  fi
}


# register widgets in zle and bind them to the specific keys
zle -N dot-expand-and-expand-or-complete dot-expand
zle -N dot-expand-and-accept-line dot-expand
bindkey '^I' dot-expand-and-expand-or-complete
bindkey '^M' dot-expand-and-accept-line
