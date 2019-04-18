# title           : dot_expand/widgets.zsh
# description     : This file provides a widget to expand multiple dots in the cd command
# date            : 2019-04-16
# dependencies    : warp.zsh
# zsh_version     : 5.7.1
# Based on http://stackoverflow.com/a/41420448/4757
# Based on https://github.com/parkercoates/dotfiles/blob/master/.zsh/expand-multiple-dots.zsh
# ====================================================================================


# expand multiple dots to parent directories, i.e. `cd ...<TAB>` expands to `cd ../../`
# TODO: better split (multiple newlines)
# TODO: check if it has to be expanded (inside '')
# TODO: only expand actual warp points (not part of other paths)
# TODO: don't expand warp points in warp -a(!) on third position
function dot-expand() {
  setopt local_options sh_word_split
  local -a splitted=( $LBUFFER )
  unsetopt local_options sh_word_split
  local warp_file_dir="$ZSH_CUSTOM_ROOT/plugins/DIRECTORY_AND_FILES/warp/.warp_points"

  for token in $splitted; do
    local warp_point="${token}"
    ## remove leading whitespace characters from the path
    warp_point="${warp_point#"${warp_point%%[![:space:]]*}"}"
    ## remove trailing whitespace characters from the path
    warp_point="${warp_point%"${warp_point##*[![:space:]]}"}"

    if ! [[ $warp_point =~ '/' ]]; then
      local warp_file_dir="$ZSH_CUSTOM_ROOT/plugins/DIRECTORY_AND_FILES/warp/.warp_points"
      local warp_point_exists=$(sed -n "/^$warp_point=/p" $warp_file_dir)
      if [[ -n $warp_point_exists ]]; then
        LBUFFER=${LBUFFER//$warp_point/${warp_point_exists#*=}}
        if [[ $token == ${splitted[-1]} ]]; then
          zle backward-char
        fi
      fi
    fi
  done

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
