# title           : dot_expand/widgets.zsh
# description     : This file provides a widget to expand multiple dots in the cd command
# date            : 2019-04-16
# dependencies    : warp.zsh
# zsh_version     : 5.7.1
# Based on http://stackoverflow.com/a/41420448/4757
# Based on https://github.com/parkercoates/dotfiles/blob/master/.zsh/expand-multiple-dots.zsh
# ====================================================================================


# expand multiple dots to parent directories, i.e. `cd ...<TAB>` expands to `cd ../../`
# TODO: only expand actual warp points (not part of other paths) -> currently won't work with whitespaces in paths (and '\")
# TODO: don't expand warp points in warp -a(!) on third position
function dot-expand() {
  local MATCHING_STRING=" $LBUFFER"
  local NEW_LBUFFER=''
  local warp_file_dir="$ZSH_CUSTOM_ROOT/plugins/DIRECTORY_AND_FILES/warp/.warp_points"
  local is_first=true
  local is_warp_expand=false
  while true; do

    if [[ ${MATCHING_STRING} =~ '(.*)[[:space:]]+(.*)' ]]; then
      # echo "CURRENT_MATCHED: |${match[2]}|"
      # echo "NEXT_MATCHED: |${match[1]}|"
      if ! [[ ${match[2]} =~ '/' ]]; then
        local warp_point_exists=$(sed -n "/^${match[2]}=/p" $warp_file_dir)
        if [[ -n $warp_point_exists ]]; then
          local single_quotes="${match[1]//[!\']/}"
          local single_count="${#single_quotes}"
          local double_quotes="${match[1]//[!\"]/}"
          local double_count="${#double_quotes}"
          if (( single_count % 2 == 0 && double_count % 2 == 0 )); then
            match[2]=${warp_point_exists#*=}
            if [[ $is_first == true ]]; then
              is_warp_expand=true
            fi
          fi

        fi
      fi
      if [[ -n ${match[2]} ]]; then
        is_first=false
      fi
      NEW_LBUFFER=" ${match[2]}$NEW_LBUFFER"
      MATCHING_STRING="${match[1]}"
    else
      break
    fi

  done

  LBUFFER="${NEW_LBUFFER:1}"
  if [[ $is_warp_expand == true ]]; then
    zle backward-char
  fi

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
