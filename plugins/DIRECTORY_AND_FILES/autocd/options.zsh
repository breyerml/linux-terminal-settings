# title           : autocd/options.zsh
# description     : This file provides options for better usage of autocd on the (nearly empty) command line
# date            : 2019-04-16
# dependencies    : warp.zsh
# zsh_version     : 5.7.1
# ====================================================================================

# easily read all lines of a file into an array
zmodload zsh/mapfile

# return all warp point names with a specific format depending on the first positional parameter
# $1 == 'space-separated': e.g. 'foo bar baz'
# $1 == 'pipe-separated': e.g. '(foo|bar|baz)'  ->  for RegEx
function _warp_point_names() {
  local warp_file_dir="$ZSH_CUSTOM_ROOT/plugins/DIRECTORY_AND_FILES/warp/.warp_points"
  local string=''
  for line in "${(f)mapfile[$warp_file_dir]}"; do
      string+="${line%%=*}|"
  done
  if [[ $1 == 'space-separated' ]]; then
    echo "${string//\|/ }"
  elif [[ $1 == 'pipe-separated' ]]; then
    echo "(${string:0:-1})"
  fi
}

# enable cd'ing without the need to type cd
setopt autocd

# don't print a TAB when entered on an empty command line
zstyle ':completion::*' insert-tab 'pending=1'

# file pattern to only complete executable files and directories
zstyle ':completion::*:-command-::' file-patterns \
 '*(#q-*):executables:Executables *(-/):directories:Directories'

# when TAB entered on an empty commmand line: complete directories and warp points
# when TAB entered on an command line only containing './': complete executable files
# # else: nomeal completion
zstyle -e ':completion::*:-command-::' tag-order \
'
    if [[ -z $PREFIX$SUFFIX ]]; then
      reply=( "local-directories:-normal local-directories:-warp:warp\ point" - )
    elif [[ $PREFIX$SUFFIX =~ ^./ ]]; then
      reply=( executables:Executables:Executables - )
    else
      reply=( )
    fi
'
# TODO: mkdir
# first try directories and then all globbed-files as Tags
zstyle ':completion::*:*:*:' tag-order \
  'local-directories:-normal
   local-directories:-warp:warp\ point
   globbed-files:-normal
   globbed-files:-warp:warp\point'

# add warp points to the completions
zstyle ':completion::*:*:*:(local-directories-warp|globbed-files-warp)' fake-always $(_warp_point_names space-separated)
zstyle ':completion::*:*:*:(local-directories-warp|globbed-files-warp)' ignored-patterns '*~$(_warp_point_names pipe-separated)'

# add description to warp points on an empty line
zstyle -e ':completion::*:*:*:(local-directories-warp|globbed-files-warp)' format '
if [[ -z $PREFIX$SUFFIX ]]; then
  reply=( "${SOLARIZED_COLORS[base2]}
 === ${FONT[bold]}%d${FONT[normal]} ===$RESET" )
fi
'

# color warp points
zstyle ':completion::*:*:*:(local-directories-warp|globbed-files-warp)' list-colors "=$(_warp_point_names pipe-separated)=38;2;181;137;0"
