# title           : warp/options.zsh
# description     : This file provides autosuggestions for warp points on every directory completing command and better autocd support
# date            : 2019-04-26
# dependencies    : -
# zsh_version     : 5.7.1
# ====================================================================================


# easily read all lines of a file into an array
zmodload zsh/mapfile

# return all warp point names with a specific format depending on the first positional parameter
# $1 == 'space-separated': e.g. 'foo bar baz'
# $1 == 'pipe-separated': e.g. '(foo|bar|baz)'  ->  for RegEx
function _warp_point_names() {
  local string=''
  for line in "${(f)mapfile[$ZSH_WARP_FILE_DIR]}"; do
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

# changes tags -> doesn't work if false :D
zstyle ':completion::*:*:*:' list-dirs-first true

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
      reply=( "local-directories local-directories:-warp:warp\ point" - )
    elif [[ $PREFIX$SUFFIX =~ ^./ ]]; then
      reply=( executables:Executables:Executables - )
    else
      reply=( )
    fi
'

# TODO: doesn't work in all cases, dirtree breaks it
# first try directories and then all globbed-files as Tags
zstyle ':completion::*:*:*:' tag-order \
  'local-directories
   directories
   local-directories:-warp:warp\ point
   directories:-warp:warp\ point
'

# fill new tags just with the currently existing warp points
zstyle ':completion::*:*:*:(local-directories-warp|directories-warp)' ignored-patterns '*'
zstyle ':completion::*:*:*:(local-directories-warp|directories-warp)' fake-always $(_warp_point_names space-separated)

# show all warp points at the bottom of the completion list
zstyle ':completion::*:*:*:(local-directories-warp|directories-warp)' group-name ''


# add description to warp points on an empty line
zstyle -e ':completion::*:*:*:(local-directories-warp|directories-warp)' format '
  reply=( "${SOLARIZED_COLORS[base2]}
 === ${FONT[bold]}%d${FONT[normal]} ===$RESET" )
'

# color warp points
zstyle ':completion::*:*:*:(local-directories-warp|directories-warp)' list-colors "=$(_warp_point_names pipe-separated)=38;2;181;137;0"
