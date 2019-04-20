# title           : warp/widgets.zsh
# description     : This file provides a widget to expand warp points
# date            : 2019-04-19
# dependencies    : -
# zsh_version     : 5.7.1
# ====================================================================================


# expand warp point names to their target directory
# TODO: only expand actual warp points (not part of other paths) -> currently won't work with whitespaces in paths (and '\")
function warp-expand() {
  ## don't expand warp points when creating or removing them while using the warp command
  if ! [[ $LBUFFER =~ '(^|&& )warp ' ]]; then
    ## prepend a whitespace to be able to match the first part of the LBUFFER
    local MATCHING_STRING=" $LBUFFER"
    ## the NEW_BUFFER holds the result after potential expandings
    local NEW_LBUFFER=''

    local is_first=true
    local is_warp_expansion=false

    ## for each token (separated by whitespaces) do
    while true; do
      ## greedy match until the last whitespace
      if [[ ${MATCHING_STRING} =~ '(.*)[[:space:]]+(.*)' ]]; then
        ## the match must not conatin any dot (or it breaks the egrep pattern)
        ## (not a problem since dots are forbidden in warp point names)
        if ! [[ ${match[2]} =~ '\.+' || ${match[2]} =~ '\*+' ]]; then
          ## try to find a warp point with the name given by the current token
          local warp_point=$(command egrep "^${match[2]}=" $ZSH_WARP_FILE_DIR)
          # echo "$warp_point"
          if [[ -n $warp_point ]]; then
            ## count the number of single quotes (') on the left side
            local single_quotes="${match[1]//[!\']/}"
            local single_count="${#single_quotes}"
            ## count the number of single quotes (") on the left side
            local double_quotes="${match[1]//[!\"]/}"
            local double_count="${#double_quotes}"
            ## only expand if the current token isn't quoted, i.e. the number of quotes to the left es even
            ## -> doesn't work with pathes containing an odd number of quotes
            if (( single_count % 2 == 0 && double_count % 2 == 0 )); then
              ## expand warp point
              match[2]=${warp_point#*=}
              ## if the first match (the one located most right) is a warp expansion
              if [[ $is_first == true ]]; then
                is_warp_expansion=true
              fi
            fi
          fi
        fi
        ## first match is over (if it wasn't empty) -> set is_first to false
        if [[ -n ${match[2]} ]]; then
          is_first=false
        fi
        ## update buffer
        NEW_LBUFFER=" ${match[2]}$NEW_LBUFFER"
        ## no try to match the remaining part of the LBUFFER
        MATCHING_STRING="${match[1]}"
      else
        break
      fi
    done

    ## override LBUFFER with the possible expanded version
    LBUFFER="${NEW_LBUFFER:1}"
    ## if the first match was a warp expansion: move delete the last character
    ## -> enables further completion
    if [[ $is_warp_expansion == true ]]; then
      zle backward-char
    fi
  fi
}


# register widget in zle
zle -N warp-expand
