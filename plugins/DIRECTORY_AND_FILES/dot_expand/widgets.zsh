# title           : dot_expand/widgets.zsh
# description     : This file provides a widget to expand multiple dots
# date            : 2019-04-19
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
}


# register widget in zle
zle -N dot-expand
