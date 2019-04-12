# title           : ccd/functions.zsh
# description     : This file provides a function to integrate the warp functionality into cd
# date            : 2019-04-12
# dependencies    : warp.zsh
# zsh_version     : 5.7.1
# ====================================================================================


# try to cd to the given directory
# -> if not possible: try to cd to a warp point with the given name
# else: return an error
function ccd() {
  ## try to normally cd
  builtin cd "$@" >/dev/null 2>&1
  ## cd doesn't work
  if [[ $? != 0 ]]; then
    local warp_point_exists=$(sed -n "/^$1=/p" $ZSH_CUSTOM_ROOT/plugins/DIRECTORY_AND_FILES/warp/.warp_points)
    if [[ -n $warp_point_exists ]]; then
        ## try to cd to a warp point
        builtin cd "${warp_point_exists#*=}"
    else
        ## illegal cd
        echoerr "cd: no such directory or warp point: $@"
        return 2
    fi
  fi
}
