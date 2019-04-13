# title           : dot_cd/functions.zsh
# description     : This file provides a widget to expand multiple dots in the cd command
# date            : 2019-04-14
# dependencies    : -
# zsh_version     : 5.7.1
# ====================================================================================


function _dot-expand {
  ## only expand dots on cd commands
  if [[ $BUFFER =~ 'cd ' ]]; then
    ## remove cd and get the path
    local current_path="${BUFFER#cd}"
    ## remove leading whitespace characters from the path
    current_path="${current_path#"${current_path%%[![:space:]]*}"}"
    ## remove trailing whitespace characters from the path
    current_path="${current_path%"${current_path##*[![:space:]]}"}"

    ## get all parts of the current path by splitting it on all '/' characters
    local tokenized_path=( "${(s:/:)current_path}" )
    local expanded_path=''
    ## try to expand dots in all tokens
    for token in $tokenized_path; do
      ## only expand tokens with more than two dots iff the token only consists of dots
      if [[ (${#token} -gt 2) && (${token:gs|.|} == '') ]]; then
        ## replace dots with the correct string (e.g. ... -> ../../)
        for ((i=0; i<${#token}-1; i++)); do
          expanded_path+="../"
        done
      else
        expanded_path+="$token/"
      fi
    done
      ## delete old line buffer and replace it with the new one
      zle kill-whole-line
      zle -U "cd $expanded_path"
  fi
}

zle -N _dot-expand
bindkey '\ed' _dot-expand
# TODO: correctly bind to <TAB>
